from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from transfers.models import Transfer
from transfers.serializers import TransferSerializer
from app.permissions import GlobalDefaultPermission


class TransferCreateListView(generics.ListCreateAPIView):
    """
    ViewSet para listar e criar transferências.

    Permite:
    - GET: Lista todas as transferências
    - POST: Cria uma nova transferência

    Attributes
    ----------
    permission_classes : tuple
        Permissões necessárias (IsAuthenticated, GlobalDefaultPermission)
    queryset : QuerySet
        QuerySet de todas as transferências
    serializer_class : class
        Serializer usado para validação e serialização
    """
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Transfer.objects.all()
    serializer_class = TransferSerializer


class TransferRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    """
    ViewSet para operações individuais em transferências.

    Permite:
    - GET: Recupera uma transferência específica
    - PUT/PATCH: Atualiza uma transferência existente
    - DELETE: Remove uma transferência

    Attributes
    ----------
    permission_classes : tuple
        Permissões necessárias (IsAuthenticated, GlobalDefaultPermission)
    queryset : QuerySet
        QuerySet de todas as transferências
    serializer_class : class
        Serializer usado para validação e serialização
    """
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Transfer.objects.all()
    serializer_class = TransferSerializer
