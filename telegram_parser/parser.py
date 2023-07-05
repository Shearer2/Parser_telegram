import datetime
import requests
from mysql.connector import connect
from bs4 import BeautifulSoup as BS


def text_news(html) -> tuple:
    ru_alf = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'
    # Добавляю информацию для удаления из текста.
    information_to_delete = ["Подпишись на канал"]
    last_news_text = html.findAll('div', class_='tgme_widget_message_bubble')[-1]
    # Если тег с сообщениями присутствует, то выполняется условие.
    if last_news_text.findAll('div', class_='tgme_widget_message_text js-message_text'):
        text = last_news_text.findAll('div', class_='tgme_widget_message_text js-message_text')[-1]
        result = [name.text for name in text]  # Здесь хранится весь текст из тегов, которые находились внутри div.
        while '' in result:  # Пока в списке есть пустые строки будет идти цикл.
            # Фильтруем список, убирая пустые строки и пробелы спереди и сзади каждого элемента списка.
            result = list(map(str.strip, list(filter(lambda x: x, result))))
            # Проходимся по списку и если следующий элемент начинается со строчной буквы, то присоединяем его
            # к предыдущему элементу, а сам элемент делаем пустым.
            for i in range(1, len(result)):
                if result[i] and result[i][0] in ru_alf:
                    result[i - 1] = result[i - 1] + ' ' + result[i]
                    result[i] = ''
        # Если первый элемент является эмодзи, то его нужно объединить со вторым элементом.
        if len(result[0]) <= 3:
            result[0] = result[0] + ' ' + result[1]
            del result[1]
        title = short_text = result[0]
        content = ' '.join(result[1:])
        # Берём каждый элемент из списка для удаления.
        for inf in information_to_delete:
            # Проверяем есть ли данный элемент в заголовке и в коротком описании.
            if inf in title:
                # Если элемент присутствует в тексте, то заменяем его на пустую строку.
                title = short_text = title.replace(inf, '')
            # Проверяем если ли данный элемент в контенте.
            if inf in content:
                content = content.replace(inf, '')
        return title, short_text, content
    return '', '', ''


def date_news(html) -> list:
    # В attrs указываем тот атрибут, который хотим взять из тега time.
    date = ' '.join(html.findAll('time', class_='time')[-1].attrs['datetime'].split('T'))
    return [date for i in range(5)]


def photo_news(html) -> list:
    # Беру последний пост и тег, в котором хранится изображение.
    last_news_photo = html.findAll('div', class_='tgme_widget_message_bubble')[-1]
    # Беру ссылку с изображениями последнего поста.
    photo = last_news_photo.findAll('a', class_='tgme_widget_message_photo_wrap')
    main_photo = []
    for i in range(len(photo)):
        res_photo = photo[i].attrs['style']  # Беру аттрибут style у тега a, содержащего изображение.
        # Нахожу (', т.е. начало ссылки и добавляю в список.
        main_photo.append(res_photo[res_photo.find("('") + 2:-2])
    return main_photo


def video_news(html) -> list:
    # Беру последний пост и тег, в котором хранится видео.
    last_news_video = html.findAll('div', class_='tgme_widget_message_bubble')[-1]
    # Беру ссылку с видео последнего поста.
    video = last_news_video.findAll('video', class_='tgme_widget_message_video js-message_video')
    main_video = [video[i].attrs['src'] for i in range(len(video))]
    return main_video


def audio_news(html) -> list:
    # Беру последний пост и тег, в котором хранится аудио.
    last_news_audio = html.findAll('div', class_='tgme_widget_message_bubble')[-1]
    # Беру ссылку с аудио последнего поста.
    audio = last_news_audio.findAll('audio', class_='tgme_widget_message_voice js-message_voice')
    main_audio = [audio[i].attrs['src'] for i in range(len(audio))]
    return main_audio


try:
    # Подключаемся к нашей базе данных.
    connection = connect(
        host='localhost',
        user=input('Введите имя пользователя: '),  # Указываем имя пользователя.
        password=input('Введите пароль от базы данных: ')  # Указываем пароль к базе данных.
    )
    connection.autocommit = True  # Нужно для отработки запроса и записи изменений в базу данных.
    # Извлечение данных из таблицы.
    with connection.cursor() as cursor:
        cursor.execute(
            """SELECT login FROM telegram.telegram_logins"""
        )  # Получаем информацию, которая хранится в таблице telegram_logins в столбце login.
        # Собираем все записи в список.
        name_channel = list(map(lambda x: x[0], cursor.fetchall()))

    with connection.cursor() as cursor:
        cursor.execute(
            """SELECT created FROM telegram.news"""
        )
        data_created = list(map(lambda x: x[0], cursor.fetchall()))

    for i in range(len(name_channel)):
        r = requests.get(f'https://t.me/s/{name_channel[i]}/')  # Проверяем соединение со страницей.
        html = BS(r.content, 'html.parser')  # Получаем весь код страницы.
        id = category_id = i + 1  # Идентификатор по соответствию нумерации в цикле.
        title, short_text, content = text_news(html)  # Здесь хранится текст.
        deleted_at, created_at, update_at, dateofevent, created = date_news(html)  # Здесь хранится дата.
        # Переводим время в нужный нам часовой пояс, так как при получении данных из базы данных оно переводится в наш
        # часовой пояс.
        time_without_timezone = created.split('+')[0]
        time_desired_timezone = str((int(created.split('+')[0][-8:-6]) + 3) % 24).zfill(2)
        date_moscow_time_zone = time_without_timezone[:-8] + time_desired_timezone + time_without_timezone[-6:]
        # Количество всех новостей.
        main_news = len(html.findAll('div', class_='tgme_widget_message_wrap js-widget_message_wrap'))
        slug = 'Null'  # Не понял, что это такое.
        organizer = html.findAll('div', class_='tgme_widget_message_author accent_color')[-1].text.strip()  # Автор.
        place = organizer  # Местом я указал канал, с которого происходит парсинг постов.
        view_count = html.findAll('span', class_='tgme_widget_message_views')[-1].text  # Количество просмотров.
        main_photo = ', '.join(photo_news(html))  # Все изображения с последнего поста, если они есть.
        main_video = ', '.join(video_news(html))  # Все видео с последнего поста, если они есть.
        main_audio = ', '.join(audio_news(html))  # Все аудио с последнего поста, если они есть.
        main_pva = main_photo + main_video + main_audio

        # Если дата из базы данных не совпадает с датой последнего поста, то мы меняем запись.
        if str(data_created[i]) != date_moscow_time_zone:
            # Используем контекстный менеджер для обновления значений в базе данных.
            with connection.cursor() as cursor:
                cursor.execute(f'''
                    update telegram.news set 
                    id = {id}, category_id = {category_id}, main_photo = '[{main_pva}]', title = '{title}',
                    short_text = '{short_text}', content = '{content}', deleted_at = '{deleted_at}',
                    created_at = '{created_at}', update_at = '{update_at}', main_news = '{main_news}', slug = {slug},
                    dateofevent = '{dateofevent}', organizer = '{organizer}', place = '{place}', created = '{created}',
                    view_count = '{view_count}'
                    where id = {id}
                ''')
                print('[INFO] Data was successfully update.')


except Exception as _ex:
    print('[INFO] Error while working with MySql', _ex)
finally:
    if connection:
        connection.close()
        print('[INFO] MySql connection closed')
