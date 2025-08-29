from django.urls import path
from . import views


urlpatterns = [
    path(
        'members/',
        views.MemberCreateListView.as_view(),
        name='member-create-list'
    ),
    path(
        'members/<int:pk>/',
        views.MemberRetrieveUpdateDestroyView.as_view(),
        name='member-detail-view'
    ),
]
