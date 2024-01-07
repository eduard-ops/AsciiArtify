Кроки для встановлення та доступу до Argo на локальному кластері.

Для прикладу використаємо minicube.

minikube start cluster запустимо наш кластер.

kubectl create namespace argocd створює неймспейс для запуску ArgoCD

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml встановлює ArgoCD на наш кластер

kubectl get pod -n argocd перевіримо запущені поди ArgoCD.

Тепер пошукаємо потрібний сервіс для доступу до UI консолі ArgoCD. kubectl get svc -n argocd повертає всі сервіси, які належать до неймспейсу ArgoCD.

один з сервісів носитиме назву argocd-server і в графі ports знаходимо 80, 443. Це той сервіс, який нам потрібний.

Викликаємо наступну команду щоб прокинути порти сервісу на нашу локальну машину: kubectl port-forward -n argocd svc/argocd-server 8080:443 

Консоль виведе нам ip адресу, скоріше за все 127.0.0.1:8080. Копіюємо її та вставляємо в браузер. Отримаємо попередження про небезпку, бо ми заходимо через https без сертифікату. Нічого страшного, все одно відкриваємо.

Далі ми бачимо сторінку логіну. Логін ми знаємо, це admin, лишилось встановити пароль.

kubectl get secret argocd-initial-admin-secret -n argocd -o yam дістане нам пароль і виведе в форматі yaml.

Копіюємо значення графи password, але воно закодоване в base64. Розкодуємо його наступною командою: echo your_password | base64 --decode

Вводимо пароль у вікні браузера і потрапляємо всередину.