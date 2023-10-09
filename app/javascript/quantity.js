document.addEventListener('DOMContentLoaded', () => {
  const quantityInputs = document.querySelectorAll('.quantity-input');
  const priceTags = document.querySelectorAll('.price-tag');
  const Inc_Or_Dec_Btn = document.getElementsByClassName('increment-decrement-button');

  function handleQuantityChange(index, increment) {
    const currentValue = parseInt(quantityInputs[index].value);
    if (increment) {
      quantityInputs[index].value = currentValue + 1;
    } else if (!increment && currentValue > 1) {
      quantityInputs[index].value = currentValue - 1;
    }
    updateProductPrice(index, quantityInputs, priceTags);
  }

  function updateProductPrice(index, quantityInputs, priceTags) {
    const quantity = parseInt(quantityInputs[index].value);
    const productPriceElement = priceTags[index].closest('.product-details');

    if (productPriceElement) {
      const productPrice = parseFloat(productPriceElement.getAttribute('data-product-price'));

      if (!isNaN(productPrice)) {
        const totalPrice = quantity * productPrice;
        priceTags[index].textContent = formatNumberAsCurrency(totalPrice);
      } else {
        console.error('Invalid product price.');
      }
    } else {
      console.error('Product details element not found.');
    }
  }

  function formatNumberAsCurrency(number, currencySymbol = '$') {
    const roundedNumber = number.toFixed(2);
    const THOUSANDS_SEPARATOR_PATTERN = /\d(?=(\d{3})+\.)/g;
    const formattedNumber = roundedNumber.replace(THOUSANDS_SEPARATOR_PATTERN, '$&,');
    return currencySymbol + formattedNumber;
  }

  for(let i=0;i<Inc_Or_Dec_Btn.length;i++)
  {
    let incOrDec = Inc_Or_Dec_Btn[i].dataset['action'] == 'increment' ? true : false
    let index = Inc_Or_Dec_Btn[i].dataset['index'];
    Inc_Or_Dec_Btn[i].addEventListener('click', () => {
      handleQuantityChange(index,incOrDec);
    });
  }
});
