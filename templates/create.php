<?php $this->layout('layout/login') ?>

<form method="post" enctype="application/x-www-form-urlencoded" class="form-signin">
    <div class="text-center mb-4">
        <img class="mb-4" src="/assets/nbr.png" alt="" width="72" height="72">
        <h1 class="h3 mb-3 font-weight-normal">Criar carteira</h1>
        <p>Mantenha seus nióbios seguros. <br><a href="/">Caso já tenha, faça login aqui.</a></p>
    </div>

    <div class="form-label-group">
        <input name="key" type="text" readonly id="private" class="form-control" value="<?php echo $key; ?>"
               placeholder="Chave Privada" required>
        <label for="inputEmail">Chave privada</label>
    </div>

    <div class="form-label-group">
        <input name="secret" type="password" id="password" class="form-control" placeholder="Senha" required autofocus>
        <label for="inputPassword">Senha</label>
    </div>

    <div class="form-label-group">
        <input name="secret2" type="password" id="password2" class="form-control" placeholder="Repetir Senha" required autofocus>
        <label for="inputPassword">Repetir Senha</label>
    </div>

    <div class="checkbox mb-3">
        <label>
            <input type="checkbox" value="remember-me"> Lembrar este computador
        </label>
    </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Entrar</button>
    <p class="mt-5 mb-3 text-muted text-center">&copy; Niobio Wallet 2018</p>
</form>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
