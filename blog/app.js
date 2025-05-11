const express = require("express");
const mysql = require("mysql");
const session = require("express-session");
const bcrypt = require("bcrypt");
const app = express();
const multer = require("multer");
const path = require("path");

app.use(express.static("public"));
app.use(express.urlencoded({ extended: false }));

app.set("views", "./views");
app.set("view engine", "ejs");

const connection = mysql.createConnection({
  host: "localhost",
  user: "ducduoc",
  password: "duoc01655175653",
  database: "blog",
});

connection.connect((err) => {
  if (err) {
    console.error("Can't connect to MySQL:", err);
    process.exit(1);
  } else {
    console.log("✅ Connected to MySQL successfully!");
  }
});

connection.on("error", (err) => {
  console.error("MySQL connection error:", err);
});

module.exports = connection;

// 写真の保存フォルダとファイル名を設定する
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "public/uploads"); // 写真の保存フォルダ
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname); // ファイル名
  },
});

const upload = multer({ storage: storage });

app.use(
  session({
    secret: "my_secret_key",
    resave: false,
    saveUninitialized: false,
  })
);

app.use((req, res, next) => {
  if (req.session.userId === undefined) {
    res.locals.userId = null;
    res.locals.username = "ゲスト";
    res.locals.isLoggedIn = false;
  } else {
    res.locals.userId = req.session.userId;
    res.locals.username = req.session.username;
    res.locals.isLoggedIn = true;
  }
  next();
});

app.use((req, res, next) => {
  if (req.session.userId) {
    connection.query(
      "SELECT profile_image FROM users WHERE id = ?",
      [req.session.userId],
      (error, results) => {
        if (results.length > 0) {
          res.locals.userProfileImage =
            results[0].profile_image || "/images/default-profile.png";
        } else {
          res.locals.userProfileImage = "/images/default-profile.png";
        }
        next();
      }
    );
  } else {
    res.locals.userProfileImage = "/images/default-profile.png";
    next();
  }
});

app.use(express.static("public"));

app.get("/", (req, res) => {
  res.render("top.ejs");
});

app.get("/list", (req, res) => {
  const productQuery = "SELECT * FROM products WHERE buyer_id IS NULL ";
  const rentalQuery = "SELECT * FROM rental WHERE rentaler_id IS NULL ";

  connection.query(productQuery, (productError, productResults) => {
    if (productError) {
      console.error(
        "❌  'products':",
        productError.code,
        productError.sqlMessage
      );
      return res.status(500).send(productError.sqlMessage);
    }

    connection.query(rentalQuery, (rentalError, rentalResults) => {
      if (rentalError) {
        console.error("❌ 'rental':", rentalError.code, rentalError.sqlMessage);
        return res.status(500).send(+rentalError.sqlMessage);
      }

      res.render("list.ejs", {
        products: productResults,
        rentals: rentalResults,
      });
    });
  });
});

app.get("/products/:id", (req, res) => {
  const id = req.params.id;

  connection.query(
    "SELECT * FROM products WHERE id = ?",
    [id],
    (error, results) => {
      if (error) {
        console.error("MySQL接続エラー:", error);
        return res
          .status(500)
          .send(
            "サーバーエラーが発生しました。しばらくしてから再試行してください。"
          );
      }

      if (results.length === 0) {
        return res.status(404).send("商品が見つかりませんでした。");
      }

      res.render("product.ejs", { product: results[0] });
    }
  );
});

app.get("/rental/:id", (req, res) => {
  const id = req.params.id;

  connection.query(
    "SELECT * FROM rental WHERE id = ?",
    [id],
    (error, results) => {
      if (error) {
        console.error("MySQL接続エラー:", error);
        return res
          .status(500)
          .send(
            "サーバーエラーが発生しました。しばらくしてから再試行してください。"
          );
      }

      if (results.length === 0) {
        return res.status(404).send("貸出本が見つかりませんでした。");
      }

      res.render("rental-detail.ejs", { rental: results[0] });
    }
  );
});

app.get("/signup", (req, res) => {
  res.render("signup.ejs", { errors: [] });
});

app.post(
  "/signup",
  upload.single("profileImage"),
  (req, res, next) => {
    console.log("入力値の空チェック");
    const username = req.body.username;
    const email = req.body.email;
    const password = req.body.password;
    const errors = [];

    if (username === "") {
      errors.push("ユーザー名が空です");
    }

    if (email === "") {
      errors.push("メールアドレスが空です");
    }

    if (password === "") {
      errors.push("パスワードが空です");
    }

    if (errors.length > 0) {
      res.render("signup.ejs", { errors: errors });
    } else {
      next();
    }
  },
  (req, res, next) => {
    console.log("メールアドレスの重複チェック");
    const email = req.body.email;
    connection.query(
      "SELECT * FROM users WHERE email = ?",
      [email],
      (error, results) => {
        if (results.length > 0) {
          res.render("signup.ejs", {
            errors: ["このメールアドレスは既に登録されています。"],
          });
        } else {
          next();
        }
      }
    );
  },
  (req, res) => {
    console.log("ユーザー登録");
    const username = req.body.username;
    const email = req.body.email;
    const password = req.body.password;
    const imagePath = req.file ? "/uploads/" + req.file.filename : null;

    bcrypt.hash(password, 10, (error, hash) => {
      if (error) {
        return res.status(500).send("パスワードのハッシュ化に失敗しました。");
      }
      const query = `
        INSERT INTO users (username, email, password, profile_image)
        VALUES (?, ?, ?, ?)
      `;

      connection.query(
        query,
        [username, email, hash, imagePath],
        (error, results) => {
          if (error) {
            console.error("ユーザー登録エラー:", error);
            return res.status(500).send("ユーザー登録に失敗しました。");
          }
          req.session.userId = results.insertId;
          req.session.username = username;
          res.redirect("/list");
        }
      );
    });
  }
);

app.get("/login", (req, res) => {
  res.render("login.ejs");
});

app.post("/login", (req, res) => {
  const email = req.body.email;
  connection.query(
    "SELECT * FROM users WHERE email = ?",
    [email],
    (error, results) => {
      if (results.length > 0) {
        const plain = req.body.password;
        const hash = results[0].password;
        bcrypt.compare(plain, hash, (error, isEqual) => {
          if (isEqual) {
            req.session.userId = results[0].id;
            req.session.username = results[0].username;
            res.redirect("/list");
          } else {
            res.render("login.ejs");
          }
        });
      } else {
        res.redirect("/login");
      }
    }
  );
});

app.get("/logout", (req, res) => {
  req.session.destroy((error) => {
    res.redirect("/list");
  });
});

app.get("/account/:id", (req, res) => {
  const userId = req.params.id;

  const userQuery = "SELECT * FROM users WHERE id = ?";
  const productsQuery = "SELECT * FROM products WHERE seller_id = ?";
  const rentalsQuery = "SELECT * FROM rental";

  connection.query(userQuery, [userId], (userError, userResults) => {
    if (userError) {
      console.error("ユーザー情報取得エラー:", userError);
      return res.status(500).send("エラーが発生しました。");
    }
    if (userResults.length === 0) {
      return res.status(404).send("ユーザーが存在しません。");
    }

    connection.query(
      productsQuery,
      [userId],
      (productsError, productResults) => {
        if (productsError) {
          console.error("商品の取得中にエラーが発生しました:", productsError);
          return res.status(500).send("エラーが発生しました。");
        }

        if (res.locals.username === "admin") {
          connection.query(rentalsQuery, (rentalError, rentalResults) => {
            if (rentalError) {
              console.error(
                "貸出登録済み本の取得中にエラーが発生しました:",
                rentalError
              );
              return res.status(500).send("エラーが発生しました。");
            }

            res.render("account.ejs", {
              user: userResults[0],
              products: productResults,
              rentals: rentalResults,
            });
          });
        } else {
          res.render("account.ejs", {
            user: userResults[0],
            products: productResults,
            rentals: [],
          });
        }
      }
    );
  });
});

// アカウントの更新
app.get("/edit-account/:id", (req, res) => {
  const userId = req.params.id;
  connection.query(
    "SELECT * FROM users WHERE id = ?",
    [userId],
    (error, results) => {
      if (error || results.length === 0) {
        console.error("エラーまたはユーザーが存在しません:", error);
        return res.status(404).send("ユーザーが存在しません。");
      }
      res.render("edit-account.ejs", { user: results[0] });
    }
  );
});

// アカウントの更新
app.post("/edit-account/:id", upload.single("profileImage"), (req, res) => {
  const userId = req.params.id;
  const { username, email } = req.body;
  const profileImage = req.file
    ? "/uploads/" + req.file.filename
    : req.body.existingImage;

  connection.query(
    "UPDATE users SET username = ?, email = ?, profile_image = ? WHERE id = ?",
    [username, email, profileImage, userId],
    (error) => {
      if (error) {
        console.error("更新エラー:", error);
        return res.status(500).send("エラーが発生しました。");
      }
      res.redirect(`/account/${userId}`);
    }
  );
});

// アカウントの削除
app.post("/delete-account/:id", (req, res) => {
  const userId = req.params.id;
  connection.query("DELETE FROM users WHERE id = ?", [userId], (error) => {
    if (error) {
      console.error("削除エラー:", error);
      return res.status(500).send("エラーが発生しました。");
    }
    req.session.destroy(() => {
      res.redirect("/");
    });
  });
});

app.get("/messenger/:id?", (req, res) => {
  const currentUserId = req.session.userId;
  let activeUserId = req.params.id || null;

  if (!currentUserId) {
    return res.status(400).send("User not logged in");
  }

  const conversationsQuery = `
    SELECT u.id AS user_id, u.username, u.profile_image, 
           (SELECT message FROM messages 
            WHERE (sender_id = u.id AND receiver_id = ?) 
               OR (sender_id = ? AND receiver_id = u.id) 
            ORDER BY created_at DESC LIMIT 1) AS last_message,
           (SELECT created_at FROM messages 
            WHERE (sender_id = u.id AND receiver_id = ?) 
               OR (sender_id = ? AND receiver_id = u.id) 
            ORDER BY created_at DESC LIMIT 1) AS last_message_time 
    FROM users u
    WHERE u.id IN (
      SELECT sender_id FROM messages WHERE receiver_id = ?
      UNION
      SELECT receiver_id FROM messages WHERE sender_id = ?
    )
    ORDER BY last_message_time DESC
  `;

  const messagesQuery = `
    SELECT * FROM messages 
    WHERE (sender_id = ? AND receiver_id = ?) 
       OR (sender_id = ? AND receiver_id = ?) 
    ORDER BY created_at ASC
  `;

  connection.query(
    conversationsQuery,
    [
      currentUserId,
      currentUserId, // last_message
      currentUserId,
      currentUserId, //  last_message_time
      currentUserId,
      currentUserId,
    ],
    (err, conversations) => {
      if (err) {
        console.error("Error fetching conversations:", err);
        return res.status(500).send("Error fetching conversations");
      }

      if (
        !activeUserId ||
        !conversations.some((c) => c.user_id == activeUserId)
      ) {
        activeUserId =
          conversations.length > 0 ? conversations[0].user_id : null;
      }

      if (activeUserId) {
        connection.query(
          messagesQuery,
          [currentUserId, activeUserId, activeUserId, currentUserId],
          (err, messages) => {
            if (err) {
              console.error("Error fetching messages:", err);
              return res.status(500).send("Error fetching messages");
            }

            const activeConversation = conversations.find(
              (c) => c.user_id == activeUserId
            );

            res.render("messenger.ejs", {
              conversations,
              messages,
              activeConversation,
              activeUserId,
              currentUserId,
            });
          }
        );
      } else {
        res.render("messenger.ejs", {
          conversations,
          messages: [],
          activeConversation: null,
          activeUserId: null,
          currentUserId,
        });
      }
    }
  );
});

app.post("/messenger/:id", (req, res) => {
  const senderId = req.session.userId;
  const receiverId = req.params.id;
  const message = req.body.message;

  const query = `
    INSERT INTO messages (sender_id, receiver_id, message) 
    VALUES (?, ?, ?)
  `;

  connection.query(query, [senderId, receiverId, message], (err) => {
    if (err) {
      console.error("Error sending message:", err);
      return res.status(500).send("Error sending message");
    }
    res.redirect(`/messenger/${receiverId}`);
  });
});

app.get("/sell/:id", (req, res) => {
  const sellerId = req.params.id;
  res.render("sell.ejs", { errors: [], sellerId });
});

app.post("/sell/:id", upload.array("images", 3), (req, res) => {
  const sellerId = req.params.id;
  const { title, describe, price } = req.body;
  const imagePaths = req.files
    ? req.files.map((file) => "/uploads/" + file.filename).join(";")
    : null;

  const query =
    "INSERT INTO products (title, `describe`, price, seller_id, buyer_id, image_path) VALUES (?, ?, ?, ?, NULL, ?)";

  connection.query(
    query,
    [title, describe, price, sellerId, imagePaths],
    (error, results) => {
      if (error) {
        console.error("エラーが発生しました:", error);
        return res.status(500).send("商品の登録に失敗しました。");
      }
      res.redirect(`/account/${sellerId}`);
    }
  );
});

app.get("/rental", (req, res) => {
  res.render("rental.ejs", { errors: [] });
});

app.post("/rental", upload.array("images", 3), (req, res) => {
  const { title, describe } = req.body;
  const imagePaths = req.files
    ? req.files.map((file) => "/uploads/" + file.filename).join(";")
    : null;

  const query =
    "INSERT INTO rental (title, `describe`, rentaler_id, image_path) VALUES (?, ?, NULL, ?)";

  connection.query(query, [title, describe, imagePaths], (error, results) => {
    if (error) {
      console.error("エラーが発生しました:", error);
      return res.status(500).send("本の登録に失敗しました。");
    }
    res.redirect("/list");
  });
});

app.get("/edit-product/:id", (req, res) => {
  const productId = req.params.id;

  const query = "SELECT * FROM products WHERE id = ?";
  connection.query(query, [productId], (error, results) => {
    if (error) {
      console.error("商品取得エラー:", error);
      return res.status(500).send("エラーが発生しました。");
    }

    if (results.length === 0) {
      return res.status(404).send("商品が存在しません。");
    }

    res.render("edit-product.ejs", { product: results[0], errors: [] });
  });
});

app.post("/edit-product/:id", upload.array("images", 3), (req, res) => {
  const productId = req.params.id;
  const { title, describe, price } = req.body;
  const imagePaths = req.files
    ? req.files.map((file) => "/uploads/" + file.filename).join(";")
    : null;

  let query;
  let queryParams;

  if (imagePaths) {
    query =
      "UPDATE products SET title = ?, `describe` = ?, price = ?, image_path = ? WHERE id = ?";
    queryParams = [title, describe, price, imagePaths, productId];
  } else {
    query =
      "UPDATE products SET title = ?, `describe` = ?, price = ? WHERE id = ?";
    queryParams = [title, describe, price, productId];
  }

  connection.query(query, queryParams, (error, results) => {
    if (error) {
      console.error("商品更新エラー:", error);
      return res.status(500).send("商品の更新に失敗しました。");
    }

    res.redirect(`/account/${req.body.seller_id}`);
  });
});

app.get("/rental-edit/:id", (req, res) => {
  const rentalId = req.params.id;

  const query = "SELECT * FROM rental WHERE id = ?";
  connection.query(query, [rentalId], (error, results) => {
    if (error) {
      console.error("貸出本取得エラー:", error);
      return res.status(500).send("エラーが発生しました。");
    }

    if (results.length === 0) {
      return res.status(404).send("貸出本が存在しません。");
    }

    res.render("rental-edit.ejs", { rental: results[0], errors: [] });
  });
});

app.post("/rental-edit/:id", upload.array("images", 3), (req, res) => {
  const rentalId = req.params.id;
  const { title, describe } = req.body;
  const imagePaths = req.files
    ? req.files.map((file) => "/uploads/" + file.filename).join(";")
    : null;

  let query;
  let queryParams;

  if (imagePaths) {
    query =
      "UPDATE rental SET title = ?, `describe` = ?, image_path = ? WHERE id = ?";
    queryParams = [title, describe, imagePaths, rentalId];
  } else {
    query = "UPDATE rental SET title = ?, `describe` = ? WHERE id = ?";
    queryParams = [title, describe, rentalId];
  }

  connection.query(query, queryParams, (error, results) => {
    if (error) {
      console.error("貸出本更新エラー:", error);
      return res.status(500).send("貸出本の更新に失敗しました。");
    }

    res.redirect(`/account/${req.session.userId}`);
  });
});

app.get("/campaign/:id", (req, res) => {
  const campaignId = req.params.id;

  res.render("campaign.ejs", { campaignId });
});

// 参加リクエスト用のエンドポイント
app.get("/join/:id", (req, res) => {
  const senderId = req.params.id;

  // 管理者のユーザーIDを取得するクエリ
  const queryAdmin = "SELECT id FROM users WHERE username = 'admin'";

  connection.query(queryAdmin, (err, results) => {
    if (err || results.length === 0) {
      console.error("管理者情報の取得中にエラーが発生しました:", err);
      return res.status(500).send("管理者の情報が見つかりません。");
    }

    const adminId = results[0].id;
    const messageContent = "本の寄付キャンペーンに参加したいです";

    // メッセージを追加するクエリ
    const queryMessage = `
      INSERT INTO messages (sender_id, receiver_id, message, created_at)
      VALUES (?, ?, ?, NOW())
    `;

    connection.query(
      queryMessage,
      [senderId, adminId, messageContent],
      (error, result) => {
        if (error) {
          console.error("メッセージの追加中にエラーが発生しました:", error);
          return res.status(500).send("メッセージを送信できませんでした。");
        }

        // メッセンジャーページにリダイレクト
        res.redirect(`/messenger/${senderId}`);
      }
    );
  });
});

app.get("/buy/:id", (req, res) => {
  const buyerId = res.locals.userId;
  const productId = req.params.id;

  const productQuery = "SELECT * FROM products WHERE id = ?";

  connection.query(
    productQuery,
    [productId],
    (productError, productResults) => {
      if (productError || productResults.length === 0) {
        console.error(
          "商品の取得中にエラーが発生しました:",
          productError || "結果が見つかりません"
        );
        return res.status(404).send("指定された商品が見つかりませんでした。");
      }

      const product = productResults[0];
      const sellerId = product.seller_id;
      const messageContent = `私は商品 '${product.title}' を購入したいです。`;

      const messageQuery = `
        INSERT INTO messages (sender_id, receiver_id, message, created_at)
        VALUES (?, ?, ?, NOW())
      `;

      connection.query(
        messageQuery,
        [buyerId, sellerId, messageContent],
        (messageError) => {
          if (messageError) {
            console.error(
              "メッセージの送信中にエラーが発生しました:",
              messageError
            );
            return res.status(500).send("メッセージを送信できませんでした。");
          }

          const updateProductQuery =
            "UPDATE products SET buyer_id = ? WHERE id = ?";

          connection.query(
            updateProductQuery,
            [buyerId, productId],
            (updateError) => {
              if (updateError) {
                console.error(
                  "商品の購入情報更新中にエラーが発生しました:",
                  updateError
                );
                return res
                  .status(500)
                  .send("商品の購入情報を更新できませんでした。");
              }

              res.redirect(`/messenger/${buyerId}`);
            }
          );
        }
      );
    }
  );
});

app.get("/rent/:id", (req, res) => {
  const rentalerId = res.locals.userId;
  const rentalId = req.params.id;

  const userQuery = "SELECT id FROM users WHERE username = 'admin'";

  connection.query(userQuery, (userError, userResults) => {
    if (userError || userResults.length === 0) {
      console.error(
        "管理者情報の取得中にエラーが発生しました:",
        userError || "管理者が見つかりません"
      );
      return res.status(500).send("管理者情報が見つかりませんでした。");
    }

    const ownerId = userResults[0].id;

    const rentalQuery = "SELECT * FROM rental WHERE id = ?";

    connection.query(rentalQuery, [rentalId], (rentalError, rentalResults) => {
      if (rentalError || rentalResults.length === 0) {
        console.error(
          "レンタル情報の取得中にエラーが発生しました:",
          rentalError || "結果が見つかりません"
        );
        return res
          .status(404)
          .send("指定されたレンタル情報が見つかりませんでした。");
      }

      const rental = rentalResults[0];
      const messageContent = `私は商品 '${rental.title}' を借りたいです。`;

      const messageQuery = `
          INSERT INTO messages (sender_id, receiver_id, message, created_at)
          VALUES (?, ?, ?, NOW())
        `;

      connection.query(
        messageQuery,
        [rentalerId, ownerId, messageContent],
        (messageError) => {
          if (messageError) {
            console.error(
              "メッセージの送信中にエラーが発生しました:",
              messageError
            );
            return res.status(500).send("メッセージを送信できませんでした。");
          }

          const updateRentalQuery =
            "UPDATE rental SET rentaler_id = ? WHERE id = ?";

          connection.query(
            updateRentalQuery,
            [rentalerId, rentalId],
            (updateError) => {
              if (updateError) {
                console.error(
                  "レンタル情報の更新中にエラーが発生しました:",
                  updateError
                );
                return res
                  .status(500)
                  .send("レンタル情報を更新できませんでした。");
              }

              res.redirect(`/messenger/${rentalerId}`);
            }
          );
        }
      );
    });
  });
});

app.listen(3000);
