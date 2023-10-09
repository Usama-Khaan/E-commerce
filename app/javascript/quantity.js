document.addEventListener('DOMContentLoaded', () => {
  const incrementButtons = document.querySelectorAll('[data-action="increment"]');
  const decrementButtons = document.querySelectorAll('[data-action="decrement"]');
  const quantityInputs = document.querySelectorAll('.quantity-input');
  const priceTags = document.querySelectorAll('.price-tag');

  incrementButtons.forEach((button, index) => {
    button.addEventListener('click', () => {
      let currentValue = parseInt(quantityInputs[index].value);
      quantityInputs[index].value = currentValue + 1;
      updateProductPrice(index, quantityInputs, priceTags);
    });
  });

  decrementButtons.forEach((button, index) => {
    button.addEventListener('click', () => {
      let currentValue = parseInt(quantityInputs[index].value);
      if (currentValue > 1) {
        quantityInputs[index].value = currentValue - 1;
        updateProductPrice(index, quantityInputs, priceTags);
      }
    });
  });

  function updateProductPrice(index, quantityInputs, priceTags) {
    const quantity = parseInt(quantityInputs[index].value);
    const productPriceElement = priceTags[index].closest('.product-details');
    if (productPriceElement) {
      const productPrice = parseFloat(productPriceElement.getAttribute('data-product-price'));
      if (!isNaN(productPrice)) {
        const totalPrice = quantity * productPrice;
        priceTags[index].textContent = formatNumberAsCurrency(totalPrice)
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
});
