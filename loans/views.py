from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from loans.models import Loan
from loans.serializers import LoanSerializer
from app.permissions import GlobalDefaultPermission


class LoanCreateListView(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Loan.objects.all()
    serializer_class = LoanSerializer


class LoanRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Loan.objects.all()
    serializer_class = LoanSerializer
