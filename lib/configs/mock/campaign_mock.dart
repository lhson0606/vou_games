import 'package:vou_games/features/campaign/domain/entities/campaign_entity.dart';

const String MOCK_CAPAIGNS_JSON = """
[
  {
    "id": 1,
    "name": "Campaign 1",
    "description": "Description for Campaign 1",
    "imageUrl": "https://example.com/image1.jpg",
    "startDate": "2023-01-01",
    "endDate": "2023-01-31",
    "status": "active",
    "location": "Location 1"
  },
  {
    "id": 2,
    "name": "Campaign 2",
    "description": "Description for Campaign 2",
    "imageUrl": "https://example.com/image2.jpg",
    "startDate": "2023-02-01",
    "endDate": "2023-02-28",
    "status": "inactive",
    "location": "Location 2"
  },
  {
    "id": 3,
    "name": "Campaign 3",
    "description": "Description for Campaign 3",
    "imageUrl": "https://example.com/image3.jpg",
    "startDate": "2023-03-01",
    "endDate": "2023-03-31",
    "status": "completed",
    "location": "Location 3"
  }
]
""";