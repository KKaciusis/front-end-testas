<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" href="./css/buttons.css">
        <link rel="stylesheet" href="./css/form.css">
        <link rel="stylesheet" href="./css/main.css">

        <title>Fcuksense</title>
    </head>
    <body>
        <main>
            <div class="left-column">
                <div class="inside">
                    <h2 class="name">Fcuksense</h2>
                    <h2 class="slogan">Artifical intelligence driving result for the travel industry</h2>
                    <p class="please">Welcome back, please login to your account</p>
                    <form class="form">
                        <div class="form-row">
                            <label for="Email">Email adress</label>
                            <input  id="Email" type="email" required>
                        </div>
                        <div class="form-row">
                            <label for="pass">Password</label>
                            <input  id="pass" type="password" required>
                        </div>
                        <div class="remmemberme">
                            <input type="checkbox" id="rememberme" name="remmemberme" value="e">
                            <label for="remmemberme">Remmember Me</label>
                            <a class="forget" href="./forgot-password/">Forget password</a>
                        </div>
                        <div class="button">
                            <button  type="submit">Login</button>
                            <button><a href="sign-up/index.php" target="_blank">Sign up</a></button>
                        </div>
                    </form>
                    <div class="bottom-links">
                        <p class="alternative" >Or login with</p>
                        <a target="_blank" href="#">Facebook</a>
                        <a target="_blank" href="#">Linkedin</a>
                        <a target="_blank" href="#">Google</a>
                    </div>
                </div>
            </div>
            <div class="right-column">
                <img src="./img/cover.png" alt="This is alternate text">
            </div>
        </main>
    </body>
</html>
