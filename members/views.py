from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from members.models import Member
from members.serializers import MemberSerializer
from app.permissions import GlobalDefaultPermission


class MemberCreateListView(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Member.objects.all()
    serializer_class = MemberSerializer


class MemberRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Member.objects.all()
    serializer_class = MemberSerializer
