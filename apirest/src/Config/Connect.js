
if (process.env.NODE_ENV !== 'production') {
    require("dotenv").config()   
}
const Connect = {
    host:  (typeof process.env.DB_HOST !== 'undefined')? process.env.DB_HOST:'',
    user:  (typeof process.env.DB_USER !== 'undefined')? process.env.DB_USER:'', 
    password:  (typeof process.env.DB_PASS !== 'undefined')? process.env.DB_PASS:'',
    database:  (typeof process.env.DB_DATABASE !== 'undefined')? process.env.DB_DATABASE:''
}

export default Connect;
