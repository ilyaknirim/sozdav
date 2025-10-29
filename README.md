# Создаватель — Полный пакет для GitHub Pages (Pskov)

Это полный набор для развертывания проекта «Создаватель» — некоммерческой платформы для мастеров и заказчиков Пскова и Псковской области.
Пакет включает фронтенд для GitHub Pages, SQL-миграции для Supabase, пример Cloudflare Worker для нотификаций и тесты.

## Быстрое содержание архива
- `docs/` — статический сайт (готово для GitHub Pages)
- `db/init.sql` — SQL скрипт для создания таблиц в Supabase
- `cloudflare/notify_worker.js` — пример worker для отправки нотификаций в Telegram
- `.github/workflows/deploy.yml` — GitHub Actions для автодеплоя `docs/`
- `tests/` — smoke-тесты для проверки интеграций
- `docs/config.js.example` — пример конфигурации (создать `config.js` локально)

## Шаги по развертыванию

### 1) Подготовка репозитория
1. Клонируй: `git clone https://github.com/ilyaknirim/sozdav.git`
2. Распакуй содержимое архива и скопируй папку `docs/` и остальные файлы в корень репозитория.
3. Закоммить и запушь в `main`.

### 2) Настройка GitHub Pages
1. В GitHub → Settings → Pages: Source -> `main` branch / `docs/` folder.
2. Сохрани — сайт станет доступен по `https://<your-username>.github.io/sozdav/`

### 3) Supabase (Free tier)
1. Создай проект на https://supabase.com
2. Открой SQL Editor и выполни `db/init.sql`
3. В Settings → API скопируй `SUPABASE_URL` и `anon` ключ — добавь в `docs/config.js` (по примеру `docs/config.js.example`).
4. На старте для тестов можно временно включить открытые политики (RLS off) для таблицы `orders` — но для безопасности позже настроить RLS.

### 4) Telegram Bot & Web App
1. Создай бота у BotFather `/newbot` -> запомни `bot username`.
2. В BotFather установи Web App URL: `https://<your-username>.github.io/sozdav/`
3. Не храните `BOT_TOKEN` в публичном коде — используйте Cloudflare Worker env vars или GitHub Secrets для серверных частей.

### 5) Cloudflare Worker (опционально для нотификаций)
1. Деплой `cloudflare/notify_worker.js` через Worker dashboard или Wrangler.
2. В настройках задать env vars: `TELEGRAM_BOT_TOKEN` и `TELEGRAM_CHAT_ID`.
3. Настройте Supabase Realtime / Webhook: при вставке новой записи в `orders` делайте POST в Worker URL (или вызывайте Worker из клиента при создании заказа).

### 6) Тесты
1. Отредактируй `tests/test_orders.sh`: подставь `SUPABASE_URL` и `ANON_KEY`; запусти `bash tests/test_orders.sh`
2. Для worker: подставь `WORKER_URL` в `tests/test_worker.sh` и запусти

## Рекомендации безопасности
- Не коммитьте `config.js` с ключами в публичный репозиторий.
- Для продакшена: включите RLS и используйте Supabase Functions или Cloudflare Worker для контролируемых вставок.
- Для нотификаций используйте серверную часть с токенами в защищенных переменных окружения (Cloudflare, Render, etc.)

## Миссия в README
Проект — некоммерческий. Сделано ради друга и ради сообщества Пскова. 
