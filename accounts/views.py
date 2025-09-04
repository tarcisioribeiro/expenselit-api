from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from accounts.models import Account
from accounts.serializers import AccountSerializer
from app.permissions import GlobalDefaultPermission


class AccountCreateListView(generics.ListCreateAPIView):
    """
    ViewSet para listar e criar contas bancárias.

    Permite:
    - GET: Lista todas as contas ordenadas por nome
    - POST: Cria uma nova conta

    Attributes
    ----------
    permission_classes : tuple
        Permissões necessárias (IsAuthenticated, GlobalDefaultPermission)
    queryset : QuerySet
        QuerySet de todas as contas
    serializer_class : class
        Serializer usado para validação e serialização
    ordering : list
        Ordenação padrão por nome
    """
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Account.objects.all()
    serializer_class = AccountSerializer
    ordering = ['name']  # Consistent ordering


class AccountRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    """
    ViewSet para operações individuais em contas bancárias.

    Permite:
    - GET: Recupera uma conta específica
    - PUT/PATCH: Atualiza uma conta existente
    - DELETE: Remove uma conta

    Attributes
    ----------
    permission_classes : tuple
        Permissões necessárias (IsAuthenticated, GlobalDefaultPermission)
    queryset : QuerySet
        QuerySet de todas as contas
    serializer_class : class
        Serializer usado para validação e serialização
    """
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Account.objects.all()
    serializer_class = AccountSerializer
