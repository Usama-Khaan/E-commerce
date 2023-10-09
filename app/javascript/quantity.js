document.addEventListener('DOMContentLoaded', () => {
  const incrementButtons = document.querySelectorAll('[data-action="increment"]');
  const decrementButtons = document.querySelectorAll('[data-action="decrement"]');
  const quantityInputs = document.querySelectorAll('.quantity-input');

  incrementButtons.forEach((button, index) => {
    button.addEventListener('click', () => {
      let currentValue = parseInt(quantityInputs[index].value);
      quantityInputs[index].value = currentValue + 1;
    });
  });

  decrementButtons.forEach((button, index) => {
    button.addEventListener('click', () => {
      let currentValue = parseInt(quantityInputs[index].value);
      if (currentValue > 0) {
        quantityInputs[index].value = currentValue - 1;
      }
    });
  });
});
