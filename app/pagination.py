from rest_framework.pagination import PageNumberPagination


class StandardResultsSetPagination(PageNumberPagination):
    page_size = 25
    page_size_query_param = 'page_size'
    max_page_size = 100

    def get_paginated_response(self, data):
        """Custom pagination response with additional metadata"""
        response = super().get_paginated_response(data)
        response.data['page_size'] = self.page_size
        response.data['total_pages'] = self.page.paginator.num_pages
        return response


class LargeResultsSetPagination(PageNumberPagination):
    """For endpoints that may return larger datasets"""
    page_size = 50
    page_size_query_param = 'page_size'
    max_page_size = 200