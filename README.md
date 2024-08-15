This is a simple analog clock display implemented in Pascal using the Lazarus Integrated Development Environment (IDE).

### Main Features

1. **Analog Clock Display**: The primary feature of the application is to display an analog clock. This is achieved through custom drawing on a form (`TForm1`). The clock's background is drawn first, followed by the clock face, numbers, and hour, minute, and second hands. The position of these hands is calculated based on the current system time.

2. **Interactive Movement**: The application allows users to move the clock around the screen by clicking and dragging it. This is facilitated by handling mouse events such as `OnMouseDown`, `OnMouseMove`, and `OnMouseUp`. When the left mouse button is pressed, the application enters a mode where it tracks the mouse movement to reposition the clock accordingly.

3. **Stay-on-Top Feature**: The form is set to stay on top of other windows (`FormStyle = fsSystemStayOnTop`), ensuring that the clock remains visible even when other applications are active.

4. **System Time Synchronization**: The clock hands are synchronized with the system time, updating every second to reflect the actual time. This is managed by a timer (`Timer1`) that triggers the `Timer1Timer` event at regular intervals, causing the clock hands to redraw themselves according to the current time.

5. **Resource Management**: The application makes use of a bitmap resource (`clockbg`) for the clock's background, demonstrating how to manage graphics resources within a Lazarus application.

### Technical Implementation

- **Pascal Language**: The application is written in Pascal, a high-level programming language known for its efficiency and readability.
- **Lazarus IDE**: It utilizes the Lazarus IDE, which is a free and open-source development tool for creating graphical applications using the Free Pascal Compiler (FPC).
- **Event-Driven Programming**: The application employs event-driven programming concepts, responding to user actions (mouse clicks and movements) and system events (timer ticks).
