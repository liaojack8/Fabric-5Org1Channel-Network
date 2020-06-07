const Koa = require('koa');
const Router = require('koa-router');
const koaBody = require('koa-body');
const bodyParser = require('koa-bodyparser');
let {invokeAdd,queryFind} = require('./application.js');
const app = new Koa();
const router = new Router();

app.use(koaBody())
app.use(bodyParser({
  extendTypes: {
    json: ['application/x-javascript'] 
  }
}));

router
.post('/invoke',async ctx => {
    // 把資料分別存在 title、body、author 等變數
    const { name, para1, para2, para3 } = ctx.request.body;
    // console.log(ctx.request.body)  
  ctx.body = await invokeAdd(name,para1,para2,para3);
  if(ctx.body==null){
      ctx.status = 404;
  }
  else{
      ctx.status = 200;
  }
})
.post('/query',async ctx => {
    // 把資料分別存在 title、body、author 等變數
    const { name } = ctx.request.body;
    // console.log(ctx.request.body)  
  ctx.body = await queryFind(name);
  if(ctx.body==null){
      ctx.status = 404;
  }
  else{
      ctx.status = 200;
  }
})

app.use(router.routes());
app.listen(8080);
console.log('node.js應用執行中...');
