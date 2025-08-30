from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from accounts.models import Account
from accounts.serializers import AccountSerializer
from app.permissions import GlobalDefaultPermission


class AccountCreateListView(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Account.objects.all()
    serializer_class = AccountSerializer
    ordering = ['name']  # Consistent ordering


class AccountRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Account.objects.all()
    serializer_class = AccountSerializer
