// this function is called to parse the data from the input
function parse_data()
{
    const textarea = document.getElementById("input");
    const text     = textarea.value;

    if (text.trim() === "")
    {
        alert("Empty Field");
        return false;
    }
    return true;
}

function SaveCheckBox()
{
    document.getElementById("myCheckbox").addEventListener("change", function() {
        if (this.checked) {
            console.log("Checkbox is checked!");
        } else {
            console.log("Checkbox is unchecked!");
        }
    });
}

// this is the function that will be called when the next button is clicked
function nextlogic()
{
    if (parse_data() === false)
        return;
    const textarea = document.getElementById("input");
    const text     = textarea.value;

    console.log(text);
    fetch("http://127.0.0.1:5000/submit", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ text: text })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Network response was not ok.");
        }
        return response.json();
    })
    .then(data => {
        console.log("Server response:", data);
    })
    .catch(error => {
        console.error("Error:", error);
    })
    SaveCheckBox()
    textarea.value = "";
    textarea.focus();
}

document.getElementById("nextbt").addEventListener("click", nextlogic);
