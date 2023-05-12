# Telegram_parser
Данная программа представляет собой парсер для сбора информации из телеграм каналов. У нас имеется три таблицы в базе данных: 1) **telegram_logins**, которая содержит названия каналов для парсинга; 2) **categories**, которая содержит их обычные названия и короткие описания; 3) **news** - таблица, в которую осуществляется сбор всей информации (фото, видео, голосовые сообщения, текст, дата публикации, количество просмотров и создатель данного контента).
### Необходимый инструментарий
Данный парсер предназначен для сбора информации с последнего поста, но при необходимости его можно переделать для парсинга большего количества постов. Для сбора информации я использовал такие телеграм каналы, как [ostorozhno_novosti](https://t.me/s/ostorozhno_novosti/), [moscowmap](https://t.me/s/moscowmap/), [readovkanews](https://t.me/s/readovkanews/), [novosti_voinaa](https://t.me/s/novosti_voinaa/), [mp3memes](https://t.me/s/mp3memes/). Для работы программы необходимо установить следующие модули: 
```
import requests
from mysql.connector import connect
from bs4 import BeautifulSoup as BS
```

Модуль _requests_ осуществляет запрос на сервер, чтобы мы могли знать, что доступ к парсингу имеется. При успешном запросе вы должны получить код 200.

Модуль _mysql.connector_ необходим для работы с базой данных **MySql**, установления соединения, а также внесения изменений в неё.

Модуль _BeautifulSoup4_ включает в себя все необходимые методы для сбора информации со страницы. Сбор информации осуществляется по html коду, то есть можно получить всё то, что имеется на странице, если знать в каком теге находится нужная нам информация.

### Написание кода
Для начала мы напишем обработчик исключений при помощи конструкции **try - except - finally**:
```
try:
    connection = connect(
        host='localhost',
        user=input('Введите имя пользователя: '),
        password=input('Введите пароль от базы данных: ')
    )
except Exception as _ex:
    print('[INFO] Error while working with MySql', _ex)
finally:
    if connection:
        connection.close()
        print('[INFO] MySql connection closed')
```
В данном случае при возникновении ошибки выводится сообщение, содержащее в себе причину появления ошибки. Переменная connection служит для установления соединения с нашей базой данных. Чтобы установить соединение необходимо указать **host**, **имя пользователя** в базе данных MySql и соответственно **пароль** от базы данных. После завершения всех нужных действий выполняется блок **finally**.

Так как у меня были подготовлены три таблицы в базе данных, то я решил считывать столбец **_login_** из таблицы **_telegram_logins_**. Этого можно добиться добавлением следующих строк кода:
```
try:
    connection = connect(
        host='localhost',
        user=input('Введите имя пользователя: '),
        password=input('Введите пароль от базы данных: ')
    )
    with connection.cursor() as cursor:                               #
        cursor.execute(                                               #
            """SELECT login FROM telegram.telegram_logins"""          #
        )                                                             #
        name_channel = list(map(lambda x: x[0], cursor.fetchall()))   #
    
except Exception as _ex:
    print('[INFO] Error while working with MySql', _ex)
finally:
    if connection:
        connection.close()
        print('[INFO] MySql connection closed')
```
Решётками (**#**) помечены новые участки кода. Для начала я создал контекстный менеджер, в котором и осуществляется сбор всей необходимой информации из таблицы **_telegram_logins_**. Метод **_cursor.execute_** позволяет выполнять с базой данных ту операцию, которая в нём записана. Поэтому я написал, что нужно из таблицы **_telegram_logins_**, которая находится в базе данных **_telegram_**, взять информацию из столбца **_login_**. Метод **_cursor.fetchall_** позволяет вывести сразу всю информацию в виде кортежа, поэтому в **_lambda_** функции я указал, что нужно брать только элемент с нулевым индексом и заносить его в список. Функция **_map_** позволяет выполнять подобные действия, так как она изменяет содержимое изначального объекта. В конечном итоге мы получили список со всеми именами групп в телеграме.

Но для парсинга информации из телеграм каналов не достаточно только взаимодействовать с базой данных. Поэтому я воспользовался модулем **BeautifulSoup4**, который позволяет собирать информацию с любого сайта, в данном случае я использовал телеграм каналы. Сбор информации производится следующим образом:
```
try:
    connection = connect(
        host='localhost',
        user=input('Введите имя пользователя: '),
        password=input('Введите пароль от базы данных: ')
    )
    with connection.cursor() as cursor:
        cursor.execute(
            """SELECT login FROM telegram.telegram_logins"""
        )
        name_channel = list(map(lambda x: x[0], cursor.fetchall()))

    for i in range(len(name_channel)):                                                                             #
        r = requests.get(f'https://t.me/s/{name_channel[i]}/')                                                     #
        html = BS(r.content, 'html.parser')                                                                        #
        id = category_id = i + 1                                                                                   #
        title, short_text, content = text_news(html)                                                               #
        deleted_at, created_at, update_at, dateofevent, created = date_news(html)                                  #
        main_news = len(html.findAll('div', class_='tgme_widget_message_wrap js-widget_message_wrap'))             #
        slug = 'Null'                                                                                              #
        organizer = html.findAll('div', class_='tgme_widget_message_author accent_color')[-1].text.strip()         #
        place = organizer                                                                                          #
        view_count = html.findAll('span', class_='tgme_widget_message_views')[-1].text                             #
        main_photo = ', '.join(photo_news(html))                                                                   #
        main_video = ', '.join(video_news(html))                                                                   #
        main_audio = ', '.join(audio_news(html))                                                                   #
        main_pva = main_photo + main_video + main_audio                                                            #
        
except Exception as _ex:
    print('[INFO] Error while working with MySql', _ex)
finally:
    if connection:
        connection.close()
        print('[INFO] MySql connection closed')
```
Для сбора сведений достаточно знать _структуру html документа_, именно по ней, а точнее по тегам и данным им классам производится поиск.

Но прежде чем приступать к сбору информации необходимо воспользоваться модулем **requests**. Данный модуль позволяет отправлять запрос на сайт и получать информацию, которая и будет демонстрировать, есть доступ к странице или нет, но это не весь функционал представленного модуля. Если запрос успешен, то мы получаем код **200**.

Для начала был создан цикл, на основе количества названий каналов, затем каждый канал проверялся на получение доступа к нему. После этого начиналось использование **BeautifulSoup4**, в котором был указан _'html.parser'_, то есть какую информацию мы хотим получить, в данном случае _html-код_ страницы. Далее осуществлялся поиск информации по просмотру кода страницы и нахождению нужных тегов.

Были объявлены переменные, в которых будет храниться конечный результат, вычисляемый в функциях. Для того чтобы взять какой-то определённый тег используется **html.findAll('название_тега', class_='название_класса')**, далее я указывал **[-1]**, так как в моём случае поиск осуществлялся последнего поста. Если указать **[-2]**, то будет найден предпоследний пост и т.д. Если нам нужно получить текстовый формат той информации, которая хранится в последнем посте, то нужно дописать **.text**, если мы не укажем, что хотим получить текст, то у нас будет выведен полный тег, информацию из которого мы хотели получить.

Для сбора текста была написана функция, в которой происходит не только поиск соответствующих тегов, но и обработка самого текста:
```
def text_news(html) -> tuple:                                                                                      #
    ru_alf = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'                                                                   #
    last_news_text = html.findAll('div', class_='tgme_widget_message_bubble')[-1]                                  #
    if last_news_text.findAll('div', class_='tgme_widget_message_text js-message_text'):                           #
        text = last_news_text.findAll('div', class_='tgme_widget_message_text js-message_text')[-1]                #
        result = [name.text for name in text]                                                                      #
        while '' in result:                                                                                        #
            result = list(map(str.strip, list(filter(lambda x: x, result))))                                       #
            for i in range(1, len(result)):                                                                        #
                if result[i] and result[i][0] in ru_alf:                                                           #
                    result[i - 1] = result[i - 1] + ' ' + result[i]                                                #
                    result[i] = ''                                                                                 #
        if len(result[0]) <= 3:                                                                                    #
            result[0] = result[0] + ' ' + result[1]                                                                #
            del result[1]                                                                                          #
        title = short_text = result[0]                                                                             #
        content = ' '.join(result[1:])                                                                             #
        return title, short_text, content                                                                          #
    return '', '', ''                                                                                              #
```
На выходе мы получаем кортеж из соответствующих элементов, содержащих в себе текст с последнего поста. В переменной **last_news_text** берётся последний _div_, в котором содержится другой тег с необходимым текстом. Далее осуществляется проверка на наличие следующего тега в посте, так как, например, в телеграм канале [mp3memes](https://t.me/s/mp3memes/) есть посты и без текста. Если данный тег отсутствует, то мы получаем на выходе кортеж из трёх пустых элементов. Иначе мы берём этот тег и в переменной **result** проходимся по всему содержимому, так как некоторый текст может быть оформлен в виде ссылок и если использовать к тегу **.text**, то мы получаем только текст, без ссылок, то есть с пропусками слов.

Но так как при считывании текста в теге присутствуют теги _br/_, то они попадают в наш список в виде пустых строк, поэтому был использован проход по списку до тех пор, пока в нём не будут удалены все пустые элементы. Через функцию **filter** были оставлены элементы, которые дают результат **True**, далее у каждого элемента были удалены пробелы в начале и в конце строки, так как ссылки отделялись от основного текста и попадали в список как отдельные элементы. Поэтому дальше осуществлялся проход по списку и если нулевой индекс следующего элемента присутствовал в переменной **ru_alf** со строчными русскими буквами, то к предыдущему элементу присоединялся данный элемент конкатенацией, а сам присоединённый элемент становился пустым.

После завершения цикла была проведена проверка на наличие эмодзи в качестве первого элемента и присоединения к нему второго элемента, если условие оказывалось истинным.

Для получения даты публикации поста была написана функция **date_news**:
```
def date_news(html) -> list:                                                                                       #
    date = ' '.join(html.findAll('time', class_='time')[-1].attrs['datetime'].split('T'))                          #
    return [date for i in range(5)]                                                                                #
```
Дата публикации поста хранится в специальном теге _time_ с классом _time_. Но так как само время не является обычным текстом и хранится в специальном атрибуте _datetime_, то мы указываем данный атрибут в **.attrs**, чтобы получить его содержимое. Далее мы разделяем время на две части по букве _T_, так как в базу данных время без разделения по данной букве не будет занесено.

Для получения фотографий с поста используется следующий код:
```
def photo_news(html) -> list:                                                                                      #
    last_news_photo = html.findAll('div', class_='tgme_widget_message_bubble')[-1]                                 #
    photo = last_news_photo.findAll('a', class_='tgme_widget_message_photo_wrap')                                  #
    main_photo = []                                                                                                #
    for i in range(len(photo)):                                                                                    #
        res_photo = photo[i].attrs['style']                                                                        #
        main_photo.append(res_photo[res_photo.find("('") + 2:-2])                                                  #
    return main_photo                                                                                              #
```
Первым делом мы берём последний тег, в котором хранится последний опубликованный пост. Далее мы берём все теги _a_, в которых и находятся изображения и проходимся по каждому из них в цикле, забирая только информацию из атрибута _style_. Но так как там содержится не только ссылка на изображение, то мы получаем и лишнюю информацию, поэтому выполняем поиск **"('"**, с которого и начинается ссылка на изображение и при помощи срезов добавляем нужную нам информацию в окончательный список.

Для получения видео и аудио использовался практически идентичный код:
```
def video_news(html) -> list:                                                                                      #
    last_news_video = html.findAll('div', class_='tgme_widget_message_bubble')[-1]                                 #
    video = last_news_video.findAll('video', class_='tgme_widget_message_video js-message_video')                  #
    main_video = [video[i].attrs['src'] for i in range(len(video))]                                                #
    return main_video                                                                                              #
```
```
def audio_news(html) -> list:                                                                                      #
    last_news_audio = html.findAll('div', class_='tgme_widget_message_bubble')[-1]                                 #
    audio = last_news_audio.findAll('audio', class_='tgme_widget_message_voice js-message_voice')                  #
    main_audio = [audio[i].attrs['src'] for i in range(len(audio))]                                                #
    return main_audio                                                                                              #
```
Только для каждой функции берётся свой тег, а затем вызывается атрибут _src_, содержащий уже готовую ссылку.

Последний шаг, который нам нужно выполнить, это занести все полученные данные в _базу данных MySql_. Подобное действие выполняется точно также, как если бы вы хотели сделать это в самой базе данных. Окончательный результат для блоков **try - except - finally**:
```
try:
    connection = connect(
        host='localhost',
        user=input('Введите имя пользователя: '),
        password=input('Введите пароль от базы данных: ')
    )
    connection.autocommit = True                                                                                    #
    with connection.cursor() as cursor:
        cursor.execute(
            """SELECT login FROM telegram.telegram_logins"""
        )
        name_channel = list(map(lambda x: x[0], cursor.fetchall()))

    for i in range(len(name_channel)):
        r = requests.get(f'https://t.me/s/{name_channel[i]}/')
        html = BS(r.content, 'html.parser')
        id = category_id = i + 1
        title, short_text, content = text_news(html)
        deleted_at, created_at, update_at, dateofevent, created = date_news(html)
        main_news = len(html.findAll('div', class_='tgme_widget_message_wrap js-widget_message_wrap'))
        slug = 'Null'
        organizer = html.findAll('div', class_='tgme_widget_message_author accent_color')[-1].text.strip()
        place = organizer
        view_count = html.findAll('span', class_='tgme_widget_message_views')[-1].text
        main_photo = ', '.join(photo_news(html))
        main_video = ', '.join(video_news(html))
        main_audio = ', '.join(audio_news(html))
        main_pva = main_photo + main_video + main_audio

        with connection.cursor() as cursor:                                                                          #
            cursor.execute(f'''                                                                                      #
                update telegram.news set                                                                             #
                id = {id}, category_id = {category_id}, main_photo = '[{main_pva}]', title = '{title}',              #
                short_text = '{short_text}', content = '{content}', deleted_at = '{deleted_at}',                     #
                created_at = '{created_at}', update_at = '{update_at}', main_news = '{main_news}', slug = {slug},    #
                dateofevent = '{dateofevent}', organizer = '{organizer}', place = '{place}', created = '{created}',  #
                view_count = '{view_count}'                                                                          #
                where id = {id}                                                                                      #
            ''')                                                                                                     #
            print('[INFO] Data was successfully update.')                                                            #


except Exception as _ex:
    print('[INFO] Error while working with MySql', _ex)
finally:
    if connection:
        connection.close()
        print('[INFO] MySql connection closed')
```
Здесь мы использовали контекстный менеджер для обновления значений в базе данных. В метод **cursor.execute** мы поместили нужную нам операцию, то есть обновление _базы данных telegram_ с таблицей _news_ необходимой информацией по значению столбца **id**. Чтобы применить все полученные изменения и отобразить их в самой базе данных используется команда **connection.autocommit = True**.

Весь приведённый код содержится в папке _telegram_parser_ в файле _parser.py_, а сама база данных хранится в файле _parser_db.sql_. Для обновления информации в таблице news достаточно запустить программу и парсинг выполнится автоматически.

Также есть возможность добавления большего количества каналов для сбора информации. Для этого достаточно добавить наименование каналов в таблицу _telegram_logins_, а затем добавить новые строки в таблицу _news_.
