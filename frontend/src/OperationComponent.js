import React from "react";
import { useState } from "react";

function OperationComponent() {
    const [first, setFirst] = useState();
    const [second, setSecond] = useState();

    function handleFirstChange(e) {
        setFirst(e.target.value);
    }

    function handleSecondChange(e) {
        setSecond(e.target.value);
    }

    function submitAdd() {
        fetch("http://localhost:3000/api/v1/add", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            },
            body: new URLSearchParams({
                first: first,
                second: second,
            }),
        })
            .then((response) => response.json())
            .then((data) => console.log(data));
    }

    function submitSubtract() { }

    return (
        <div>
            <label>First number:</label>
            <input
                type="number"
                onChange={(e) => handleFirstChange(e)}
                value={first}
            />

            <label>Second number:</label>
            <input
                type="number"
                onChange={(e) => handleSecondChange(e)}
                value={second}
            />

            <button onClick={submitAdd}> Add </button>
            <button onClick={submitSubtract}> Subtract </button>
        </div>
    );
}

export default OperationComponent;
