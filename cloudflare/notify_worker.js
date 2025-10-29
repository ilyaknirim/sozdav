/*
Cloudflare Worker: notify Telegram about new order.
Deploy via Cloudflare dashboard or Wrangler.
Set environment variables: TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID
*/
addEventListener('fetch', event => {
  event.respondWith(handle(event.request))
})

async function handle(request){
  if(request.method !== 'POST') return new Response('Method Not Allowed', {status:405});
  const data = await request.json();
  const title = data.title || 'Новый заказ';
  const description = data.description || '';
  const budget = (data.budget_min||'') + '-' + (data.budget_max||'');
  const text = `🔔 *Создаватель* — новый заказ\n*${title}*\n${description}\nБюджет: ${budget}`;
  const token = TELEGRAM_BOT_TOKEN;
  const chatId = TELEGRAM_CHAT_ID;
  const url = `https://api.telegram.org/bot${token}/sendMessage`;
  const body = {
    chat_id: chatId,
    text: text,
    parse_mode: 'Markdown'
  };
  const resp = await fetch(url, { method:'POST', headers:{ 'Content-Type':'application/json' }, body: JSON.stringify(body) });
  return new Response(JSON.stringify({ok:true, status: resp.status}), {status:200, headers:{'Content-Type':'application/json'}});
}
