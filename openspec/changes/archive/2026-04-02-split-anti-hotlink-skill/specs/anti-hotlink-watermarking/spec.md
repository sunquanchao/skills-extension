## ADDED Requirements

### Requirement: Image watermarking
The skill SHALL provide implementations for adding watermarks to images.

#### Scenario: Simple text watermark
- **WHEN** user needs to add user ID watermark to images
- **THEN** skill provides PIL-based watermark_image function with position options

#### Scenario: Tiled watermark pattern
- **WHEN** user needs robust watermarking resistant to cropping
- **THEN** skill provides tiled_watermark function with opacity control

### Requirement: PDF watermarking
The skill SHALL provide implementations for watermarking PDF documents.

#### Scenario: PDF text watermark
- **WHEN** user needs to add watermark to PDF
- **THEN** skill provides PyPDF2-based watermarking code

### Requirement: Video watermarking
The skill SHALL provide guidance for video watermarking approaches.

#### Scenario: FFmpeg watermark
- **WHEN** user needs to watermark videos
- **THEN** skill provides FFmpeg command for overlay watermarking
