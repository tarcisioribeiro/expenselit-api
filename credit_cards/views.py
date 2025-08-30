from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from credit_cards.models import (
    CreditCard,
    CreditCardBill,
    CreditCardExpense
)
from credit_cards.serializers import (
    CreditCardSerializer,
    CreditCardBillsSerializer,
    CreditCardExpensesSerializer
)
from app.permissions import GlobalDefaultPermission


class CreditCardCreateListView(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = CreditCard.objects.select_related('associated_account').all()
    serializer_class = CreditCardSerializer
    ordering = ['name']


class CreditCardRetrieveUpdateDestroyView(
    generics.RetrieveUpdateDestroyAPIView
):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = CreditCard.objects.select_related('associated_account').all()
    serializer_class = CreditCardSerializer


class CreditCardBillCreateListView(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = CreditCardBill.objects.select_related('credit_card', 'credit_card__associated_account').all()
    serializer_class = CreditCardBillsSerializer
    ordering = ['-year', '-month', '-invoice_ending_date']


class CreditCardBillRetrieveUpdateDestroyView(
    generics.RetrieveUpdateDestroyAPIView
):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = CreditCardBill.objects.select_related('credit_card', 'credit_card__associated_account').all()
    serializer_class = CreditCardBillsSerializer


class CreditCardExpenseCreateListView(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = CreditCardExpense.objects.select_related('card', 'card__associated_account').all()
    serializer_class = CreditCardExpensesSerializer
    ordering = ['-date', '-id']


class CreditCardExpenseRetrieveUpdateDestroyView(
    generics.RetrieveUpdateDestroyAPIView
):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = CreditCardExpense.objects.select_related('card', 'card__associated_account').all()
    serializer_class = CreditCardExpensesSerializer
