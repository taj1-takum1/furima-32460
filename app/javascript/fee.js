function fee() {
  const price = document.getElementById("item-price");
  price.addEventListener("keyup", (e) => {
    const priceVal = price.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    const t = priceVal * 0.1
    const tax = Math.floor(t)
    addTaxPrice.innerHTML = `${tax}`;

    const profit = document.getElementById("profit");
    const salesProfit = priceVal - tax
    profit.innerHTML = `${salesProfit}`;
  })
}
window.addEventListener('load',fee);