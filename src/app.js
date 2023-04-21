window.addEventListener('load', async ()=>{
  if (typeof window.ethereum !== "undefined") {
    await getNumberOfMedicines()
    await getAllMedicines(numberOfMedicines)   

  } else {
      window.open("https://metamask.io/download/", "_blank");
  }

})

async function getNumberOfMedicines(){
  fetch('MedicineList.json')
      .then((response) => response.json())
      .then(async (json) => {
        const web3 = new Web3("http://localhost:7545")
        const medicineListContract = new web3.eth.Contract(json['abi'], json['networks']['5777']['address'])
        await medicineListContract.methods.numberOfMedicines().call(function (err, res) {
          if (err) {
            console.log("An error occurred", err)
            return undefined
          }
          const numberOfMedicines = res;
          document.getElementById("numberOfMedicines").innerText = "Number of medicines in the database: " + res
          return numberOfMedicines
        })
        // ethereum.Contract(json['abi'])
      });
}

async function getAllMedicines(numberOfMedicines){
  fetch('MedicineList.json')
  .then((response) => response.json())
  .then(async (json) => {
    const web3 = new Web3("http://localhost:7545")
    const medicineListContract = new web3.eth.Contract(json['abi'], json['networks']['5777']['address'])
    let numberOfMedicines;
    await medicineListContract.methods.numberOfMedicines().call(function (err, res) {
      if (err) {
        console.log("An error occurred", err)
        return
      }
      numberOfMedicines = res;
      document.getElementById("numberOfMedicines").innerText = "Number of medicines in the database: " + res
    })
    if(numberOfMedicines != undefined){
      for(let i=0;i<numberOfMedicines;i++){
        await medicineListContract.methods.listOfMedicines(i+1).call(function(err, res) {
          if(err){
            console.log("An error occurred", err)
            return
          }
          console.log(res)
          var ul = document.getElementById("medicineList");
          var li = document.createElement("li");
          li.appendChild(document.createTextNode(res[1]));
          ul.appendChild(li);
        })
      }
    }
    // ethereum.Contract(json['abi'])
  });        
}