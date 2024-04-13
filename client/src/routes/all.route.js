require('dotenv').config();

// Trả về trang 404 cho tất cả các đường dẫn không được thiết lập
module.exports = (app) => {
    app.all('*', (req, res, next) => {
        return res.render('404');
    });
};
