import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../providers/course_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/course_model.dart';

class CoursePlayerScreen extends StatefulWidget {
  final String courseId;

  const CoursePlayerScreen({super.key, required this.courseId});

  @override
  State<CoursePlayerScreen> createState() => _CoursePlayerScreenState();
}

class _CoursePlayerScreenState extends State<CoursePlayerScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  Lesson? _currentLesson;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final courseProvider = Provider.of<CourseProvider>(context, listen: false);
      courseProvider.fetchCourseById(widget.courseId).then((_) {
        if (courseProvider.selectedCourse != null &&
            courseProvider.selectedCourse!.lessons.isNotEmpty) {
          _loadVideo(courseProvider.selectedCourse!.lessons[0]);
        }
      });
    });
  }

  Future<void> _loadVideo(Lesson lesson) async {
    // Dispose previous controllers
    _chewieController?.dispose();
    _videoPlayerController?.dispose();

    setState(() {
      _currentLesson = lesson;
    });

    // Initialize video player
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(lesson.videoUrl));
    await _videoPlayerController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: false,
      aspectRatio: 16 / 9,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                'Error loading video',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );

    setState(() {});
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Player'),
      ),
      body: Consumer<CourseProvider>(
        builder: (context, courseProvider, child) {
          if (courseProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final course = courseProvider.selectedCourse;
          if (course == null) {
            return const Center(child: Text('Course not found'));
          }

          return Column(
            children: [
              // Video Player
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.black,
                  child: _chewieController != null &&
                          _chewieController!.videoPlayerController.value.isInitialized
                      ? Chewie(controller: _chewieController!)
                      : const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                ),
              ),

              // Course Info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentLesson?.title ?? course.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.instructorName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              const Divider(),

              // Lessons List
              Expanded(
                child: ListView.builder(
                  itemCount: course.lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = course.lessons[index];
                    final isCurrentLesson = _currentLesson?.id == lesson.id;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isCurrentLesson
                            ? AppTheme.primaryColor
                            : AppTheme.primaryColor.withOpacity(0.1),
                        child: Icon(
                          isCurrentLesson ? Icons.play_arrow : Icons.play_circle_outline,
                          color: isCurrentLesson ? Colors.white : AppTheme.primaryColor,
                        ),
                      ),
                      title: Text(
                        lesson.title,
                        style: TextStyle(
                          fontWeight: isCurrentLesson ? FontWeight.bold : FontWeight.normal,
                          color: isCurrentLesson ? AppTheme.primaryColor : null,
                        ),
                      ),
                      subtitle: Text('${lesson.duration} min'),
                      onTap: () {
                        _loadVideo(lesson);
                      },
                      selected: isCurrentLesson,
                      selectedTileColor: AppTheme.primaryColor.withOpacity(0.05),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
