docker-compose build
docker-compose run --rm list_pay_ms rails db:create
docker-compose run --rm list_pay_ms rails db:migrate
docker-compose up
