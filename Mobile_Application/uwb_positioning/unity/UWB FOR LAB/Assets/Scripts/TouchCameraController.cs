using UnityEngine;

public class TouchCameraController : MonoBehaviour
{
    public float rotateSpeed = 0.2f;
    public float zoomSpeed = 0.5f;
    public float panSpeed = 0.005f;
    public float minZoom = 2f;
    public float maxZoom = 15f;
    public float minVerticalAngle = -80f;
    public float maxVerticalAngle = 80f;

    private Camera cam;
    private Vector3 centerPoint = new Vector3(4f, 0f, 4f);
    private Vector3 lastTouchPosition;
    private Vector2 lastPanPosition;
    private bool isRotating = false;
    private bool isPanning = false;

    void Start()
    {
        cam = Camera.main;
    }

    void Update()
    {
        // ======= MOBILE INPUT =======
        if (Input.touchCount == 1)
        {
            Touch touch = Input.GetTouch(0);

            if (touch.phase == TouchPhase.Began)
            {
                lastTouchPosition = touch.position;
                isRotating = true;
            }
            else if (touch.phase == TouchPhase.Moved && isRotating)
            {
                Vector2 delta = touch.deltaPosition;
                RotateCamera(delta);
                lastTouchPosition = touch.position;
            }
            else if (touch.phase == TouchPhase.Ended)
            {
                isRotating = false;
            }
        }
        else if (Input.touchCount == 2)
        {
            isRotating = false;

            Touch touch0 = Input.GetTouch(0);
            Touch touch1 = Input.GetTouch(1);

            // === Zoom ===
            Vector2 prevTouch0 = touch0.position - touch0.deltaPosition;
            Vector2 prevTouch1 = touch1.position - touch1.deltaPosition;

            float prevMag = (prevTouch0 - prevTouch1).magnitude;
            float currentMag = (touch0.position - touch1.position).magnitude;
            float diff = currentMag - prevMag;

            Zoom(diff * zoomSpeed * Time.deltaTime);

            // === Pan ===
            Vector2 midCurr = (touch0.position + touch1.position) * 0.5f;

            if (touch0.phase == TouchPhase.Began || touch1.phase == TouchPhase.Began)
            {
                lastPanPosition = midCurr;
                isPanning = true;
            }
            else if ((touch0.phase == TouchPhase.Moved || touch1.phase == TouchPhase.Moved) && isPanning)
            {
                Vector2 deltaMid = midCurr - lastPanPosition;
                Pan(deltaMid);
                lastPanPosition = midCurr;
            }
        }

        // ======= PC INPUT =======
#if UNITY_EDITOR
        float scroll = Input.GetAxis("Mouse ScrollWheel");
        if (scroll != 0.0f)
        {
            Zoom(scroll * 1000 * zoomSpeed * Time.deltaTime);
        }

        if (Input.GetMouseButtonDown(0))
        {
            lastTouchPosition = Input.mousePosition;
            isRotating = true;
        }
        else if (Input.GetMouseButton(0) && isRotating)
        {
            Vector3 delta = Input.mousePosition - lastTouchPosition;
            RotateCamera(delta);
            lastTouchPosition = Input.mousePosition;
        }
        else if (Input.GetMouseButtonUp(0))
        {
            isRotating = false;
        }

        if (Input.GetMouseButtonDown(1))
        {
            lastTouchPosition = Input.mousePosition;
        }
        else if (Input.GetMouseButton(1))
        {
            Vector3 delta = Input.mousePosition - lastTouchPosition;
            Vector3 right = cam.transform.right;
            Vector3 up = cam.transform.up;
            cam.transform.position -= (right * delta.x + up * delta.y) * panSpeed;
            lastTouchPosition = Input.mousePosition;
        }
#endif
    }

    void Zoom(float increment)
    {
        Vector3 direction = cam.transform.forward;
        cam.transform.position += direction * increment;

        float distance = Vector3.Distance(cam.transform.position, centerPoint);
        if (distance < minZoom)
            cam.transform.position = centerPoint + direction * minZoom;
        else if (distance > maxZoom)
            cam.transform.position = centerPoint + direction * maxZoom;
    }

    void Pan(Vector2 delta)
    {
        Vector3 right = cam.transform.right;
        Vector3 up = cam.transform.up;
        Vector3 move = (-right * delta.x - up * delta.y) * panSpeed;
        cam.transform.position += move;
    }

    void RotateCamera(Vector2 delta)
    {
        // Xoay ngang (Y axis)
        transform.RotateAround(centerPoint, Vector3.up, delta.x * rotateSpeed);

        // Xoay dọc (X axis)
        Vector3 right = cam.transform.right;
        float angleBefore = cam.transform.eulerAngles.x;
        transform.RotateAround(centerPoint, right, -delta.y * rotateSpeed);

        // Giới hạn góc dọc
        float xAngle = cam.transform.eulerAngles.x;
        xAngle = (xAngle > 180) ? xAngle - 360 : xAngle;

        if (xAngle < minVerticalAngle || xAngle > maxVerticalAngle)
        {
            // Undo xoay nếu vượt quá giới hạn
            transform.RotateAround(centerPoint, right, delta.y * rotateSpeed);
        }
    }
}
