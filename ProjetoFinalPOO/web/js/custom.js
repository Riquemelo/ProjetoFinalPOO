$(document).ready(function() {
  $('.data').mask('00/00/0000');
  $('.cep').mask('00000-000');
  $('.numero').mask('00000000');
  $('.telefone').mask('(00) 0000-00000');
  $('.hora').mask('00:00');
  $('.cpf').mask('000.000.000-00', {reverse: true});
  $('.cnpj').mask('00.000.000/0000-00', {reverse: true});
  $('.rg').mask('00.000.000-0', {reverse: true});
});
