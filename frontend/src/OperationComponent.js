import React from "react";
import { useState } from "react";

function OperationComponent() {
  const [first, setFirst] = useState("");
  const [second, setSecond] = useState("");
  const [result, setResult] = useState(
    "Please enter two numbers and choose an operation",
  );
  const [error, setError] = useState("");

  function handleFirstChange(e) {
    setFirst(e.target.value);
  }

  function handleSecondChange(e) {
    setSecond(e.target.value);
  }

  function submitAdd() {
    // Referenced from: https://stackoverflow.com/questions/35325370/how-do-i-post-a-x-www-form-urlencoded-request-using-fetch
    fetch(process.env.REACT_APP_BACKEND_URL + "/api/v1/add", {
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
    fetch(process.env.REACT_APP_BACKEND_URL + "/api/v1/subtract", {
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
    if (response.status === 200) {
      response.json().then((data) => setResult(data.result));
      setError("");
    } else if (response.status === 400)
      response.json().then((data) => {
        setResult("");
        setError(data.error);
      });
  }

  return (
    <div className="m-auto mt-36 max-w-96 flex flex-col rounded-xl px-20 py-12 bg-white">
      <h2 className="my-6 text-center font-bold text-2xl">
        <p>GovTech CFT OA</p> <p>Darren Chan </p>{" "}
      </h2>
      <div className="flex flex-col">
        <label className="mt-2 mb-3">First number:</label>
        <input
          className="py-2 px-4 block w-full outline-black outline outline-1 rounded-lg"
          type="number"
          onChange={(e) => handleFirstChange(e)}
          value={first}
        />
      </div>

      <div className="flex flex-col">
        <label className="my-3">Second number:</label>
        <input
          className="py-2 px-4 block w-full outline-black outline outline-1 rounded-lg"
          type="number"
          onChange={(e) => handleSecondChange(e)}
          value={second}
        />
      </div>

      <div className="flex justify-between mt-12">
        <button
          onClick={submitAdd}
          className="px-3 py-2 min-w-24 rounded outline outline-1 outline-black hover:bg-gray-400"
        >
          Add
        </button>
        <button
          onClick={submitSubtract}
          className="bg-gray-800 text-white px-3 py-2 min-w-24 rounded outline outline-1 outline-black hover:bg-gray-400 hover:text-black"
        >
          Subtract
        </button>
      </div>
      <div className="text-center mt-5">
        <p>Your answer is:</p>
        {result}
      </div>
      {error == "" ? <></> : <div className="text-red-800 text-center mt-5">Error: {error}</div>}
    </div>
  );
}

export default OperationComponent;
