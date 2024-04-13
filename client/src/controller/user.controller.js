const axios = require('../config/axios');
const appError = require('../error/appError');
const cookieOption = require('../config/token');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const userController = {
    getUserInfor: async (req, res, next) => {
        try {
            const id = req.params.id;

            const userData = await axios.get(
                `${process.env.SERVER_DOMAIN}/user/id=${id}`
            );

            const productData = await axios.get(
                `${process.env.SERVER_DOMAIN}/product/user=${id}`
            );

            const data = {
                user: userData.data,
                product: productData.data,
            };

            return res.render('userInfor', { data: data });
        } catch (err) {
            next(new appError(err));
        }
    },

    getSellerInfor: async (req, res, next) => {
        try {
            let userData;
            const token = req.cookies.accessToken;
            if (token) userData = jwt.decode(token);

            const productData = await axios.get(
                `${process.env.SERVER_DOMAIN}/product/user=${userData.user_id}`
            );

            userData = await axios.get(
                `${process.env.SERVER_DOMAIN}/user/id=${userData.user_id}`
            );

            const data = {
                user: userData.data,
                product: productData.data,
            };

            return res.render('sellerInfor', { data: data });
        } catch (err) {
            next(new appError(err));
        }
    },

    logInView: async (req, res, next) => {
        try {
            return res.render('logIn', { layout: 'empty' });
        } catch (err) {
            next(new appError(err));
        }
    },

    logIn: async (req, res, next) => {
        try {
            const userData = await axios.post(
                `${process.env.SERVER_DOMAIN}/user/login`,
                {
                    username: req.body.username,
                    password: req.body.password,
                    provider: req.body.provider,
                }
            );

            res.cookie('accessToken', userData.data.accessToken, cookieOption);
            res.cookie(
                'refreshToken',
                userData.data.refreshToken,
                cookieOption
            );

            return res.redirect('/');
        } catch (err) {
            if (err.response.status === 401)
                return res.redirect(req.headers.referer);
            next(new appError(err));
        }
    },

    signUpView: async (req, res, next) => {
        try {
            return res.render('signUp', { layout: 'empty' });
        } catch (err) {
            next(new appError(err));
        }
    },

    signUp: async (req, res, next) => {
        try {
            const userData = await axios.post(
                `${process.env.SERVER_DOMAIN}/user/signup`,
                {
                    username: req.body.username,
                    password: req.body.password,
                    phonenumber: req.body.phonenumber,
                    provider: req.body.provider,
                    avatar: req.body.avatar,
                }
            );

            res.cookie(
                'accessToken',
                userData.data.data.accessToken,
                cookieOption
            );
            res.cookie(
                'refreshToken',
                userData.data.data.refreshToken,
                cookieOption
            );

            return res.redirect('/');
        } catch (err) {
            next(new appError(err));
        }
    },

    logOut: (req, res, next) => {
        res.clearCookie('refreshToken');
        res.clearCookie('accessToken');
        return res.redirect('/');
    },

    // system admin login
    systemLogin: async (req, res, next) => {
        try {
            return res.render('admin/adminSystem/logIn', { layout: 'empty' });
        } catch (err) {
            next(new appError(err));
        }
    },

    systemDeleteUser: async (req, res, next) => {
        try {
            const id = req.params.id;
            const adminId = req.params.adminId;
            console.log(id, adminId);

            const usersData = await axios.get(
                `${process.env.SERVER_DOMAIN}/user`
            );

            const adminData = await axios.get(
                `${process.env.SERVER_DOMAIN}/user/id=${adminId}`
            );

            const rs = await axios.get(
                `${process.env.SERVER_DOMAIN}/user/delete/${id}`
            );

            const data = {
                user: adminData.data,
                product: usersData.data,
            };

            return res.render('admin/adminSystem/systemControl', {
                layout: 'admin',
                data: data,
            });
        } catch (err) {
            next(new appError(err));
        }
    },

    systemLogInHanle: async (req, res, next) => {
        try {
            const userData = await axios.post(
                `${process.env.SERVER_DOMAIN}/user/login`,
                {
                    username: req.body.username,
                    password: req.body.password,
                    provider: req.body.provider,
                }
            );

            // check user data
            const decode = jwt.decode(userData.data.accessToken);

            if (decode.user_role === 'admin') {
                const usersData = await axios.get(
                    `${process.env.SERVER_DOMAIN}/user`
                );
                const data = {
                    user: [decode],
                    product: usersData.data,
                };
                console.log(data);

                return res.render('admin/adminSystem/systemControl', {
                    layout: 'admin',
                    data: data,
                });
            }

            return res.render('admin/adminSystem/logIn', { layout: 'empty' });
        } catch (err) {
            next(new appError(err));
        }
    },

    updateUser: async (req, res, next) => {
        try {
            const { user_id, user_name, phone_number, address } = req.body;
            console.log(user_id, user_name, phone_number, address);

            await axios.post(`${process.env.SERVER_DOMAIN}/user/update`, {
                user_id,
                user_name,
                phone_number,
                address,
            });

            const productData = await axios.get(
                `${process.env.SERVER_DOMAIN}/product/user=${user_id}`
            );

            const userData = await axios.get(
                `${process.env.SERVER_DOMAIN}/user/id=${user_id}`
            );

            const data = {
                user: userData.data,
                product: productData.data,
            };

            return res.render('sellerInfor', { data: data });
        } catch (err) {
            next(new appError(err));
        }
        34;
    },
};

module.exports = userController;
