function toggleWarning(input) {
    var warningSpan = document.getElementById('aviso-' + input.id.split('-')[1]);
    if (input.value === '0') {
        warningSpan.style.display = 'inline';
    } else {
        warningSpan.style.display = 'none';
    }
}