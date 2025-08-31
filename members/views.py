from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from members.models import Member
from members.serializers import MemberSerializer
from app.permissions import GlobalDefaultPermission


class MemberCreateListView(generics.ListCreateAPIView):
    """
    ViewSet para listar e criar membros.
    
    Permite:
    - GET: Lista todos os membros
    - POST: Cria um novo membro
    
    Attributes
    ----------
    permission_classes : tuple
        Permissões necessárias (IsAuthenticated, GlobalDefaultPermission)
    queryset : QuerySet
        QuerySet de todos os membros
    serializer_class : class
        Serializer usado para validação e serialização
    """
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Member.objects.all()
    serializer_class = MemberSerializer


class MemberRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    """
    ViewSet para operações individuais em membros.
    
    Permite:
    - GET: Recupera um membro específico
    - PUT/PATCH: Atualiza um membro existente
    - DELETE: Remove um membro
    
    Attributes
    ----------
    permission_classes : tuple
        Permissões necessárias (IsAuthenticated, GlobalDefaultPermission)
    queryset : QuerySet
        QuerySet de todos os membros
    serializer_class : class
        Serializer usado para validação e serialização
    """
    permission_classes = (IsAuthenticated, GlobalDefaultPermission,)
    queryset = Member.objects.all()
    serializer_class = MemberSerializer
