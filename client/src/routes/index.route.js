const express = require('express');
const router = express.Router();
const productController = require('../controller/product.controller');
const userController = require('../controller/user.controller');
require('dotenv').config();

// Thiết lập các đường dẫn cho client
const routes = (app) => {
    // product
    router.get('/', productController.getAll);

    router.get(
        '/userId=:userId/productId=:productId',
        productController.getProductById
    );

    router.get('/category=:id', productController.getProductsByCategory);

    router.post('/search', productController.searchProduct);

    router.get('/favorite', productController.getFavorite);

    // user
    router.get('/user/:id', userController.getUserInfor);

    router.get('/login', userController.logInView);

    router.post('/login', userController.logIn);

    router.get('/signup', userController.signUpView);

    router.post('/signup', userController.signUp);

    router.get('/logout', userController.logOut);

    router.post('/user/update', userController.updateUser);

    // admin

    router.get(
        '/seller',
        (req, res, next) => {
            if (!req.cookies.accessToken) return res.render('404');
            next();
        },
        userController.getSellerInfor
    );

    // system admin controller
    router.get('/system/login', userController.systemLogin);

    router.post('/system/login', userController.systemLogInHanle);

    router.get(
        '/user/delete/id=:id/adminId=:adminId',
        userController.systemDeleteUser
    );

    return app.use('/', router);
};

module.exports = routes;
