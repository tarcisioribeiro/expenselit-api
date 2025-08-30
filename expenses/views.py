from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from django_filters import rest_framework as filters
from expenses.models import Expense
from expenses.serializers import ExpenseSerializer
from expenses.filters import ExpenseFilter
from app.permissions import GlobalDefaultPermission


class ExpenseCreateListView(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Expense.objects.select_related('account').all()
    serializer_class = ExpenseSerializer
    filter_backends = [filters.DjangoFilterBackend]
    filterset_class = ExpenseFilter
    ordering = ['-date', '-id']  # Consistent ordering for pagination


class ExpenseRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Expense.objects.select_related('account').all()
    serializer_class = ExpenseSerializer
