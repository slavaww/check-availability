# Website Availability Check

This script checks the availability of a website on the internet.
It runs every 2 minutes via the server's cron. In case no response
(after a set number of requests) site sends messages to Slack
and/or Telegram.

## Installation

1. Copy the script file `check_sites.sh` and the file `sites.txt` to the server.
2. Set permissions to run the script: `chmod +x check_sites.sh`
3. Edit the `/etc/sites_monitor.conf` file by adding the websites to be monitored.
   There must be an empty line at the end of the file!
4. Set up the server cron, for example, by running `crontab -e`. In the opened
   editor, add the following line (to run every 2 minutes):

   ```bash
   */2 * * * * /path/to/check_sites.sh
   ```

5. Register a webhook (something like
   TRXXXXXXX/XXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX) in Slack and add it to
   line 40 of the check_sites.sh script.
6. In line 35 of the check_sites.sh script, enter the channel in which you
will go messages.
7. Create a bot in Telegram and get an access token:
   - Find @BotFather on Telegram and send the command /newbot.
   - Follow the instructions to create a bot and receive a token.
8. Find out your chat ID:
   - Find @userinfobot on Telegram and send the /start command.
   - Write down the value User ID.
9. Enter the data from points 7 and 8 in lines 8 and 10 in check_sites.sh

   ### If you don’t need messages in Telegram or Slack

10. Comment out lines 43-45 of the check_sites.sh file if you don’t need Telegram
11. Comment out line 40 of the check_sites.sh file if you don’t need Slack

### Good luck

## Проверка доступности сайта в сети

Скрипт проверяет доступность сайта в сети интернет.
Запускается каждые 2 минуты по крону сервера. В случае
отсутствия ответа (после установленного количества запросов)
сайта шлет сообщения в Слак и/или Телеграм

## Установка

1. Скопировать файл скрипта check_sites.sh и файл sites.txt на сервер.
2. Установите права на запуск скрипта: `chmod +x check_sites.sh`
3. Отредактировать файл `/etc/sites_monitor.conf` добавив в него сайты для мониторинга
   В конце файла должна быть пустая строка!
4. Настроить крон сервера, например, `crontab -e`. В открывшемся
   редакторе добавить строку (для запуска каждые 2 минуты):

   ```bash
   */2 * * * * /path/to/check_sites.sh
   ```

5. Зарегистрируйте веб-хук (что-то типа
   TRXXXXXXX/XXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX) в Слаке и добавьте в
   строку 40 скрипта check_sites.sh
6. В строку 35 скрипта check_sites.sh впишите канал, в который будут
   идти сообщения.
7. Создайте бота в Telegram и получите токен доступа:
   - Найдите @BotFather в Telegram и отправьте команду /newbot.
   - Следуйте инструкциям для создания бота и получите токен.
8. Узнайте свой идентификатор чата:
   - Найдите @userinfobot в Telegram и отправьте команду /start.
   - Запишите значение User ID.
9. Впишите данные из пунктов 7 и 8 в строки 8 и 10 в check_sites.sh

   ### Если не нужно сообщения в Телеграм или Слак

10. Закомментируйте строки 43-45 файла check_sites.sh если не нужен Телеграм
11. Закомментируйте строку 40 файла check_sites.sh если не нужен Слак

### Удачи
