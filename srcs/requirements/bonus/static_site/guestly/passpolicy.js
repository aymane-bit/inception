const passwordInput = document.getElementById("pass_re");
const rule1 = document.getElementById("rule1");
const rule2 = document.getElementById("rule2");
const rule3 = document.getElementById("rule3");
const register_button = document.getElementById("register_btn");

register_button.disabled = true;

passwordInput.addEventListener("input", function () {
    const password = passwordInput.value;
    const hasUppercase = /[A-Z]/.test(password);
    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

    if (password.length >= 8)
        rule1.style.color = "green";
    else
        rule1.style.color = "red";
    if (hasUppercase)
        rule2.style.color = "green";
    else
        rule2.style.color = "red";
    if (hasSpecialChar)
        rule3.style.color = "green";
    else
        rule3.style.color = "red";

    if (password.length >= 8 && hasUppercase && hasSpecialChar)
        register_button.disabled = false;
    else
        register_button.disabled = true;
});
