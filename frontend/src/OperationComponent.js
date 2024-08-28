import React from "react";
import { useState } from "react";

function OperationComponent() {
  const [first, setFirst] = useState();
  const [second, setSecond] = useState();
  const [result, setResult] = useState();
  const [error, setError] = useState();

  function handleFirstChange(e) {
    setFirst(e.target.value);
  }

  function handleSecondChange(e) {
    setSecond(e.target.value);
  }

  function submitAdd() {
    // Referenced from: https://stackoverflow.com/questions/35325370/how-do-i-post-a-x-www-form-urlencoded-request-using-fetch
    fetch("http://localhost:3000/api/v1/add", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: new URLSearchParams({
        first: first,
        second: second,
      }),
    }).then((response) => {
      displayResult(response);
    });
  }

  function submitSubtract() {
    // Referenced from: https://stackoverflow.com/questions/35325370/how-do-i-post-a-x-www-form-urlencoded-request-using-fetch
    fetch("http://localhost:3000/api/v1/subtract", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: new URLSearchParams({
        first: first,
        second: second,
      }),
    }).then((response) => {
      displayResult(response);
    });
  }

  function displayResult(response) {
    if (response.status === 200)
      response.json().then((data) => setResult(data.result));
    else if (response.status === 400)
      response.json().then((data) => {
        setResult();
        setError(data.result);
      });
  }

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
      <div>{result}</div>
    </div>
  );
}

export default OperationComponent;
