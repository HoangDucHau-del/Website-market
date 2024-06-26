const appError = require('../errors/appError');
const pool = require('../config/connectDB');
const { statusCode, message } = require('../until/httpResponse');
let query;

const productController = {
    // get all products
    getALl: async (req, res, next) => {
        try {
            // truy vấn chưa có lấy ra tên danh mục
            query =
                'select tb_product.*, tb_product_images.image_link from tb_product inner join tb_product_images on tb_product.product_id = tb_product_images.product_id where tb_product_images.type = ? and tb_product.is_deleted = ? order by tb_product.create_at desc';
            const [data] = await pool.execute(query, ['main', 0]);

            return res.status(statusCode.OK).json(data);
        } catch (err) {
            next(new appError(err));
        }
    },

    // get all categories
    getCategories: async (req, res, next) => {
        try {
            query = 'select * from tb_category';

            const [data] = await pool.execute(query);

            return res.status(statusCode.OK).json(data);
        } catch (err) {
            next(new appError(err));
        }
    },

    // get product by id
    getProductById: async (req, res, next) => {
        try {
            let productId = req.params.id;

            // get product information
            query =
                'select tb_product.*, tb_category.* from tb_product' +
                ' inner join tb_category on tb_product.category_id = tb_category.category_id' +
                ' where product_id = ?';
            const [product] = await pool.execute(query, [productId]);

            // get product images
            query = 'select * from tb_product_images where product_id = ?';
            const [images] = await pool.execute(query, [productId]);

            // merge image data into product data
            const data = { product: product, images: images };

            return res.status(statusCode.OK).json(data);
        } catch (err) {
            next(new appError(err));
        }
    },

    // get product by category
    getProductsByCategory: async (req, res, next) => {
        try {
            const categoryId = req.params.id;

            // get product information
            query =
                'select tb_product.*, tb_category.*, tb_product_images.image_link from tb_product' +
                ' inner join tb_product_images on tb_product.product_id = tb_product_images.product_id' +
                ' inner join tb_category on tb_product.category_id = tb_category.category_id' +
                ' where tb_product_images.type = ? and tb_product.is_deleted = ? and tb_product.category_id = ? order by tb_product.create_at desc';

            const [data] = await pool.execute(query, ['main', 0, categoryId]);

            return res.status(statusCode.OK).json(data);
        } catch (err) {
            next(new appError(err));
        }
    },

    // get product by user
    getProductByUser: async (req, res, next) => {
        try {
            const userId = req.params.id;

            query =
                'select tb_product.*, tb_category.*, tb_product_images.image_link from tb_product' +
                ' inner join tb_product_images on tb_product.product_id = tb_product_images.product_id' +
                ' inner join tb_category on tb_product.category_id = tb_category.category_id' +
                ' where tb_product_images.type = ? and tb_product.is_deleted = ? and tb_product.user_id = ? order by tb_product.create_at desc';

            const [data] = await pool.execute(query, ['main', 0, userId]);

            return res.status(statusCode.OK).json(data);
        } catch (err) {
            next(new appError(err));
        }
    },

    // get deleted prds from the user
    getDeletedPrds: async (req, res, next) => {
        try {
            const userId = req.params.id;

            query =
                'select tb_product.*, tb_category.*, tb_product_images.image_link from tb_product' +
                ' inner join tb_product_images on tb_product.product_id = tb_product_images.product_id' +
                ' inner join tb_category on tb_product.category_id = tb_category.category_id' +
                ' where tb_product_images.type = ? and tb_product.is_deleted = ? and tb_product.user_id = ? order by tb_product.create_at desc';

            const [data] = await pool.execute(query, ['main', 1, userId]);

            return res.status(statusCode.OK).json(data);
        } catch (err) {
            next(new appError(err));
        }
    },

    // add images of products
    addImages: async (req, res, next, productId) => {
        try {
            const image_main = req.files.image_main[0]; // the main image has only 1 image information.
            const image_sub = req.files.image_sub;

            query =
                'insert into tb_product_images (product_id, image_link, type) values (?, ?, ?)';

            // insert main image
            await pool.execute(query, [productId, image_main.path, 'main']);

            // insert sub images
            for (const e of image_sub) {
                await pool.execute(query, [productId, e.path, 'sub']);
            }
        } catch (err) {
            next(new appError(err));
        }
    },

    // create new product
    addProduct: async (req, res, next) => {
        try {
            query =
                'insert into tb_product (user_id, category_id, product_name, price, description) values(?, ?, ?, ?, ?)';
            const { user_id, category_id, product_name, price, description } =
                req.body;

            // check uploaded images
            const files = req.files;
            if (!files) next(new appError('No file uploaded!'));

            const [result] = await pool.execute(query, [
                user_id,
                category_id,
                product_name,
                price,
                description,
            ]);

            // insert images into database
            await productController.addImages(req, res, next, result.insertId);

            return res.status(statusCode.OK).json(message.SUCCESS);
        } catch (err) {
            next(new appError(err));
        }
    },

    // edit product
    editProduct: async (req, res, next) => {
        try {
            query =
                'update tb_product set `product_name`=?,`product_type`=?,`price`=?,`description`=?,`state`=? where product_id=?;';

            const productId = req.params.id;
            const { productName, productType, price, description, state } =
                req.body;
            const file = req.file;
            if (file) {
                // Delete old image
                await productControler.deleteOldImage(image);

                await pool.execute(query, [
                    nameproduct,
                    file.path,
                    priceproduct,
                    condproduct,
                    productId,
                ]);
            } else
                await pool.execute(query, [
                    nameproduct,
                    image,
                    priceproduct,
                    condproduct,
                    productId,
                ]);

            return res.status(statusCode.OK).json('product updated!');
        } catch (err) {
            next(new appError(err));
        }
    },

    // update product state
    updatePrdState: async (req, res, next) => {
        try {
            query = 'update tb_product set `state`=? where product_id=?;';
            const productId = req.params.id;
            const state = req.body.state;

            await pool.execute(query, [state, productId]);

            return res.status(statusCode.OK).json('product updated');
        } catch (err) {
            next(new appError(err));
        }
    },

    // delete product temporarily
    deleteProduct: async (req, res, next) => {
        try {
            query = 'update tb_product set `is_deleted`=? where product_id=?;';
            const productId = req.params.id;

            await pool.execute(query, [1, productId]);

            return res.status(statusCode.OK).json('product deleted');
        } catch (err) {
            next(new appError(err));
        }
    },

    // delete selected products temporarily
    deleteSelectedProducts: async (req, res, next) => {
        try {
            const selectdId = req.body;
            query = `update tb_product set is_deleted = ? where product_id IN (${selectdId.join(
                ','
            )})`;

            const result = await pool.execute(query, [1]);

            return res.status(statusCode.OK).json(result);
        } catch (err) {
            next(new appError(err));
        }
    },

    // delete product forever
    deleteProductForever: async (req, res, next) => {
        try {
            const productId = req.params.id;

            // delete images prd
            query = 'delete from tb_product_images where product_id=?;';
            await pool.execute(query, [productId]);

            // delete prd
            query = 'delete from tb_product where product_id=?;';
            await pool.execute(query, [productId]);

            return res.status(statusCode.OK).json('product deleted');
        } catch (err) {
            next(new appError(err));
        }
    },

    // restore product
    restoreProduct: async (req, res, next) => {
        try {
            query = 'update tb_product set `is_deleted`=? where product_id=?;';
            const productId = req.params.id;

            await pool.execute(query, [0, productId]);

            return res.status(statusCode.OK).json('product deleted');
        } catch (err) {
            next(new appError(err));
        }
    },

    // search products
    searchProduct: async (req, res, next) => {
        try {
            query =
                'select tb_product.*, tb_product_images.image_link from tb_product inner join tb_product_images on tb_product.product_id = tb_product_images.product_id where tb_product_images.type = ? and tb_product.is_deleted = ? and tb_product.product_name like ? order by tb_product.create_at desc';

            const keyword = req.body.keyword;
            const params = `%${keyword}%`;
            const [data] = await pool.execute(query, ['main', 0, params]);

            return res.status(statusCode.OK).json([data]);
        } catch (e) {
            next(new appError(err));
        }
    },
};

module.exports = productController;
