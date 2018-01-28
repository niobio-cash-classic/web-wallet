<?php $this->layout('layout/login') ?>

<form class="form-signin">
    <div class="text-center mb-4">
        <img class="mb-4" src="/assets/nbr.png" alt="" width="72" height="72">
        <h1 class="h3 mb-3 font-weight-normal">Niobio Carteira Web</h1>
        <p>Mantenha seus nióbios online. <br><a href="/create">Caso ainda não tenha, crie a sua aqui.</a></p>
    </div>

    <div class="form-label-group">
        <input type="text" id="key" class="form-control" placeholder="Chave Privada" required autofocus>
        <label for="inputEmail">Chave privada</label>
    </div>

    <div class="form-label-group">
        <input type="password" id="inputPassword" class="form-control" placeholder="Senha" required>
        <label for="inputPassword">Senha</label>
    </div>

    <div class="checkbox mb-3">
        <label>
            <input type="checkbox" value="remember-me"> Lembrar este computador
        </label>
    </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Entrar</button>
    <p class="mt-5 mb-3 text-muted text-center">&copy; Niobio Cash 2018 - <a target="_blank" href="//niobiocash.com">http://niobiocash.com</a></p>
</form>
