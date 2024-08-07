# Website Availability Check

This script checks the availability of a website on the internet.
It runs every 2 minutes via the server's cron. If the site does not respond within 15 minutes, it sends messages
to Slack and/or Telegram.

## Installation

1. Copy the script file `check_sites.sh` and the file `sites.txt` to the server.
2. Edit the `sites.txt` file by adding the websites to be monitored.
There must be an empty line at the end of the file!
3. Set up the server cron, for example, by running `crontab -e`. In the opened
editor, add the following line (to run every 2 minutes):
```bash
*/2 * * * * /path/to/check_sites.sh
```
4.	Register a webhook (something like
TRXXXXXXX/XXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX) in Slack and add it to
line 27 of the check_sites.sh script.
5.	Enter the channel where the messages will be sent on line 21 of the check_sites.sh script.

### For Telegram messages:

6.	Create a bot in Telegram and get the access token:
	*	Find @BotFather in Telegram and send the command /newbot.
	*	Follow the instructions to create a bot and get the token.
7.	Find out your chat ID:
	*	Find @userinfobot in Telegram and send the command /start.
	*	Note the User ID value.
8.	Enter the data from steps 6 and 7 into lines 12 and 14 of the check_sites.sh script.

### Good luck!



# Проверка доступности сайта в сети

Скрипт проверяет доступность сайта в сети интернет.
Запускается каждые 2 минуты по крону сервера. В случае
отсутствия ответа сайта в течение 15 минут шлет сообщения
в Слак и/или Телеграм

## Установка

1. Скопировать файл скрипта check_sites.sh и файл sites.txt на сервер.
2. Отредактировать файл sites.txt добавив в него сайты для мониторинга
В конце файла должна быть пустая строка!
3. Настроить крон сервера, например, `crontab -e `. В открывшемся
редакторе добавить строку (для запуска каждые 2 минуты):
``` bash
*/2 * * * * /path/to/check_sites.sh
```
4. Зарегистрируйте веб-хук (что-то типа
TRXXXXXXX/XXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX) в Слаке и добавьте в 
строку 27 скрипта check_sites.sh
5. В строку 21 скрипта check_sites.sh впишите канал, в который будут
идти сообщения.

### Если нужно сообщения в Телеграм:

6. Создайте бота в Telegram и получите токен доступа:
	*	Найдите @BotFather в Telegram и отправьте команду /newbot.
	*	Следуйте инструкциям для создания бота и получите токен.
7. Узнайте свой идентификатор чата:
	*	Найдите @userinfobot в Telegram и отправьте команду /start.
	*	Запишите значение User ID.
8. Впишите данные из пунктов 6 и 7 в строки 12 и 14 в check_sites.sh

### Удачи!