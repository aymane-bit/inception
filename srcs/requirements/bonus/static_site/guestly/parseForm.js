// for login form
const email = document.getElementById("email_log");
const password = document.getElementById("pass_hidden");
const form = document.getElementById("loginForm");
const error = document.getElementById("error_handel"); // used for both
// for register form
const register_form = document.getElementById("registerForm");
const name_re = document.getElementById("name_re");
const email_re = document.getElementById("email_re");
const pass_re = document.getElementById("pass_re");
const pass_confirm_re = document.getElementById("pass_confirm_re");

// show the error msj for an invalid user
function InvalidUser() {

    document.querySelector("#loginForm h1").style.top = "-200px";
    error.innerText = "Invalid username or password";
    error.style.top = "160px";
    error.style.left = "1227px";
    error.style.backgroundColor = "#9b0f0f";
    error.style.border = "2px solid #9b0f0f";
    error.style.color = "#fff";
    error.style.visibility = "visible";    
}

// succes login 
function LoginSucces() {
    document.querySelector("#loginForm h1").style.top = "-200px";
    error.innerText = "Welcome";
    error.style.top = "160px";
    error.style.left = "1227px";
    error.style.visibility = "visible";
    error.style.backgroundColor = "#A0C878";
    error.style.border = "2px solid #3E7B27";
    error.style.color = "#3E7B27";
}

// check if the credential are valid
function UserCheck()
{
    const email_db = email.value;
    const password_db = password.value;

    fetch("http://127.0.0.1:5000/login", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            email_db: email_db,
            password_db: password_db
        })
    })
    .then(response => {
        if (response.status === 401)
            InvalidUser();
        if (!response.ok) {
            throw new Error("Network response was not ok.");
        }
        return response.json();
    })
    .then(data => {
        console.log("Server response:", data);
        LoginSucces();
    })
    .catch(error => {
        console.error("Error:", error);
    });
}

// handel the login form when submit it 
form.addEventListener('submit', (e) => {
    const mail = document.getElementsByClassName("input-box");
    let errorMessages = [];

    if (!email.validity.valid)
    {
        if (email.value === '')
            errorMessages.push('Email is required');
        else
            errorMessages.push('Invalid Email');
        document.querySelector("#loginForm h1").style.top = "-200px";
        error.style.visibility = "visible";
        error.style.top = "160px";
        error.style.left = "1227px";
    }
    if (email.validity.valid)
    {
        if (password.value === '' && password.value.length === 0)
        {
            errorMessages.push('Password is required');
            document.querySelector("#loginForm h1").style.top = "-200px";
            error.style.visibility = "visible";    
        }

    }
    error.innerText = errorMessages.join(', ');
    UserCheck();
    e.preventDefault();
})

function name_check() {
    if (name_re.value === "")
        return false;
    return true;
}

function email_check() {
    if (email_re.value === '')
        return false;
    return true;
}

// check the field if they are empty
function checkForEmptyField(){

    name_re.style.border = "2px solid #123458";
    email_re.style.border = "2px solid #123458";
    pass_re.style.border = "2px solid #123458";
    pass_confirm_re.style.border = "2px solid #123458";

    if (name_re.value === '')
    {
        name_re.style.border = "2px solid #9b0f0f";
        return true;
    }
    if (email_re.value === '')
    {
        email_re.style.border = "2px solid #9b0f0f";
        return true;
    }
    if (pass_re.value === '')
    {
        pass_re.style.border = "2px solid #9b0f0f";
        return true;
    }
    if (pass_confirm_re.value === '')
    {
        pass_confirm_re.style.border = "2px solid #9b0f0f";
        return true;
    }
    return false;
}

// show the error msj 
function show_error_dev() { 
    document.querySelector("#registerForm h1").style.top = "-190px";
    error.style.left = "150px";
    error.style.top = "90px";
    error.style.backgroundColor = "#9b0f0f";
    error.style.border = "2px solid #9b0f0f";
    error.style.color = "#fff";
    error.style.visibility = "visible";
}

// when the user is register succesfuly
function RegisterSucces(){
    show_error_dev();
    error.style.backgroundColor = "#A0C878";
    error.style.border = "2px solid #3E7B27";
    error.style.color = "#3E7B27";
    error.innerText = "Account Created Succesfuly"
}

// handel the existing email
function EmailExist() {
    show_error_dev();
    error.innerText = "This Email Already Exist";
}

// send data to back-end for storing
function StoreToDb() {
    const name = name_re.value;
    const email = email_re.value;
    const password = pass_re.value;

    fetch("http://127.0.0.1:5000/register", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            name: name,
            email: email,
            password: password
        })
    })
    .then(response => {
        if (response.status === 409)
            EmailExist();
        if (!response.ok) {
            throw new Error("Network response was not ok.");
        }
        return response.json();
    })
    .then(data => {
        console.log("Server response:", data);
        RegisterSucces();
    })
    .catch(error => {
        console.error("Error:", error);
    });
}


register_form.addEventListener('submit', (e) => {
    let errorMessages = [];

    e.preventDefault();
    if (checkForEmptyField() === true)
        return ;
    if (!email_re.validity.valid)
    {
        errorMessages.push('Invalid Email');
        show_error_dev();
    }
    else if (pass_re.value !== pass_confirm_re.value)
    {
        errorMessages.push('Password Dont Match');
        show_error_dev();
        pass_confirm_re.style.border = "2px solid #9b0f0f";
        pass_re.style.border = "2px solid #9b0f0f";

    }
    else
    {
        StoreToDb();
    }
    error.innerText = errorMessages.join(', ');
})

