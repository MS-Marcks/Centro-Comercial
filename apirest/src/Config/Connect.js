
if (process.env.NODE_ENV !== 'production') {
    require("dotenv").config()   
}
const Connect = {
    host:  (typeof process.env.DB_HOST !== 'undefined')? process.env.DB_HOST:'68.183.162.131',
    user:  (typeof process.env.DB_USER !== 'undefined')? process.env.DB_USER:'pvivirtual_pvivirtual', 
    password:  (typeof process.env.DB_PASS !== 'undefined')? process.env.DB_PASS:'I.P2^49R!Ha1',
    database:  (typeof process.env.DB_DATABASE !== 'undefined')? process.env.DB_DATABASE:'pvivirtual_comercial'
}

export default Connect;
