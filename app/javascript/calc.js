function calc() {
  const itemPrice = document.getElementById("item-price")
  itemPrice.addEventListener("keyup", () => {
    const calcAddTaxPrice = itemPrice.value / 10;
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = `${calcAddTaxPrice}`;
    const calcProfit = `${itemPrice.value - calcAddTaxPrice}`;
    const profit = document.getElementById("profit");
    profit.innerHTML = `${calcProfit}`;
  });
}

window.addEventListener('load', calc)