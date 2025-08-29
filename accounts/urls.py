from django.urls import path
from . import views


urlpatterns = [
    path(
        'accounts/',
        views.AccountCreateListView.as_view(),
        name='account-create-list'
    ),
    path(
        'accounts/<int:pk>/',
        views.AccountRetrieveUpdateDestroyView.as_view(),
        name='account-detail-view'
    ),
]
