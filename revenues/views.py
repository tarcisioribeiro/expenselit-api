from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from revenues.models import Revenue
from revenues.serializers import RevenueSerializer
from app.permissions import GlobalDefaultPermission


class RevenueCreateListView(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Revenue.objects.select_related('account').all()
    serializer_class = RevenueSerializer
    ordering = ['-date', '-id']  # Consistent ordering for pagination


class RevenueRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Revenue.objects.select_related('account').all()
    serializer_class = RevenueSerializer
