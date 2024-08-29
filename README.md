# Website Availability Check

This script checks the availability of a website on the internet.
It runs every 2 minutes via the server's cron. If the site does not respond within 15 minutes, it sends messages
to Slack and/or Telegram.

## Installation

1. Copy the script file `check_sites.sh` and the file `sites.txt` to the server.
2. Set permissions to run the script: `chmod +x check_sites.sh`
3. Edit the `sites.txt` file by adding the websites to be monitored.
   There must be an empty line at the end of the file!
4. Set up the server cron, for example, by running `crontab -e`. In the opened
   editor, add the following line (to run every 2 minutes):

```bash
*/2 * * * * /path/to/check_sites.sh
```

5. Register a webhook (something like
   TRXXXXXXX/XXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX) in Slack and add it to
   line 27 of the check_sites.sh script.
6. Enter the channel where the messages will be sent on line 21 of the check_sites.sh script.

### For Telegram messages:

7. Uncomment lines 33-36 of the check_sites.sh file
8. Create a bot in Telegram and get the access token:
   - Find @BotFather in Telegram and send the command /newbot.
   - Follow the instructions to create a bot and get the token.
9. Find out your chat ID:
   - Find @userinfobot in Telegram and send the command /start.
   - Note the User ID value.
10. Enter the data from steps 8 and 9 into lines 12 and 14 of the check_sites.sh script.

### Good luck!

# Проверка доступности сайта в сети

Скрипт проверяет доступность сайта в сети интернет.
Запускается каждые 2 минуты по крону сервера. В случае
отсутствия ответа сайта в течение 15 минут шлет сообщения
в Слак и/или Телеграм

## Установка

1. Скопировать файл скрипта check_sites.sh и файл sites.txt на сервер.
2. Установите права на запуск скрипта: `chmod +x check_sites.sh`
3. Отредактировать файл sites.txt добавив в него сайты для мониторинга
   В конце файла должна быть пустая строка!
4. Настроить крон сервера, например, `crontab -e `. В открывшемся
   редакторе добавить строку (для запуска каждые 2 минуты):

```bash
*/2 * * * * /path/to/check_sites.sh
```

5. Зарегистрируйте веб-хук (что-то типа
   TRXXXXXXX/XXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX) в Слаке и добавьте в
   строку 27 скрипта check_sites.sh
6. В строку 21 скрипта check_sites.sh впишите канал, в который будут
   идти сообщения.

### Если нужно сообщения в Телеграм:

7. Раскомментируйте строки 33-36 файла check_sites.sh
8. Создайте бота в Telegram и получите токен доступа:
   - Найдите @BotFather в Telegram и отправьте команду /newbot.
   - Следуйте инструкциям для создания бота и получите токен.
9. Узнайте свой идентификатор чата:
   - Найдите @userinfobot в Telegram и отправьте команду /start.
   - Запишите значение User ID.
10. Впишите данные из пунктов 8 и 9 в строки 12 и 14 в check_sites.sh

### Удачи!
