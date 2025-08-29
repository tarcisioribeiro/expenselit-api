from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from transfers.models import Transfer
from transfers.serializers import TransferSerializer
from app.permissions import GlobalDefaultPermission


class TransferCreateListView(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Transfer.objects.all()
    serializer_class = TransferSerializer


class TransferRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Transfer.objects.all()
    serializer_class = TransferSerializer
