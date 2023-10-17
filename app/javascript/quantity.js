document.addEventListener('DOMContentLoaded', () => {
  const quantityInputs = document.querySelectorAll('.quantity-input');
  const priceTags = document.querySelectorAll('.price-tag');
  const increaseOrDecreaseBtn = document.getElementsByClassName('increment-decrement-button');
  const total_price_element = document.getElementById('total-price');
  const THOUSANDS_SEPARATOR_PATTERN = /\d(?=(\d{3})+\.)/g;

  function handleQuantityChange(index, increment) {
    const currentValue = parseInt(quantityInputs[index].value);

    if (increment) {
      quantityInputs[index].value = currentValue + 1;
    } else if (!increment && currentValue > 1) {
      quantityInputs[index].value = currentValue - 1;
    }
    updateTotalPrice();
  }

  function updateTotalPrice() {
    let totalPrice = 0;
    for (let i = 0; i < quantityInputs.length; i++) {
      const quantity = parseInt(quantityInputs[i].value);
      const productPrice = parseFloat(priceTags[i].textContent.replace(/\$|,/g, ''));
      if (!isNaN(quantity) && !isNaN(productPrice)) {
        totalPrice += quantity * productPrice;
      }
    }
    total_price_element.textContent = formatNumberAsCurrency(totalPrice);
  }

  function formatNumberAsCurrency(number, currencySymbol = '$') {
    const roundedNumber = number.toFixed(2);
    const formattedNumber = roundedNumber.replace(THOUSANDS_SEPARATOR_PATTERN, '$&,');
    return currencySymbol + formattedNumber;
  }

  for (let i = 0; i < increaseOrDecreaseBtn.length; i++) {
    let incOrDec = increaseOrDecreaseBtn[i].dataset['action'] == 'increment' ? true : false;
    let index = increaseOrDecreaseBtn[i].dataset['index'];
    increaseOrDecreaseBtn[i].addEventListener('click', () => {
      handleQuantityChange(index, incOrDec);
    });
  }
  updateTotalPrice();
});
