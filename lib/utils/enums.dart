enum VisitStatus {
  completed('Completed'),
  pending('Pending'),
  cancelled('Cancelled');

  const VisitStatus(this.name);
  final String name;
}
