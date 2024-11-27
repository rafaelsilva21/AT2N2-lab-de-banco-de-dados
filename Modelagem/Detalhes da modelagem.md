### Usuário
O tipo blob foi escolhido para guardar as fotos dos usuários. Pesquisa feita: o blob armazena dados binários e é utilizado para armazenar tanto imagens, como videos, audio, e até arquivos.

### Conexões
Para fazer a conexão foi decidido que pode um usuario seguir o outro de modo unilateral, sem que, necessáriamente, este siga de volta.
Semelhante ao que temos no instagram. Uma tabela de conexão irá armazenar isto.

### Postagens
Usado blob para o conteudo, pois se adequa pelo seu multiuso.

### Comentários
Como podem ter comentários de comentários, e eles não se diferenciam no formato dos comentários de postagem, eles são de uma mesma tabela.
São declarados tbm os atributos Postagen_idPostagem e Comentarios_idComentarios quem podem ser vazios para referenciar o que foi comentado(uma postagem ou outro comentário).

### Avaliações
A mesma lógica dos comentários é aplicado para as avaliações, de modo que há dois atributos para referenciar a postagem ou o comentário.

### Notificações
Seguindo o mesmo pensamento, foi usado dois campos para referenciar o a postagem ou o comentário alvo da notificação.
Como não foi específicado, não é armazenado dados adicionais do comentário ou avaliação que gerou a notificação, apenas o tipo da origem.

### Tags e Inscrições
Sem muito o que falar sobre, para filtrar as funcionalidades de um usuario em um grupo tem um campo de função na tabela Inscrições.

### Mensagens Privadas
Para fazer em forma de chat,precisa do id de quem enviou e de quem recebeu. Também haverá várias mensagens entre eles, por isso são chaves estrangeiras.
O timestamp (formato para data e hora) irá permitir apresentar as mensagens como um histório.
